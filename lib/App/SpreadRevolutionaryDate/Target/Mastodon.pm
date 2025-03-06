use 5.014;
use utf8;
package App::SpreadRevolutionaryDate::Target::Mastodon;

# ABSTRACT: Target class for L<App::SpreadRevolutionaryDate> to handle spreading on Mastodon.

use Moose;
with 'App::SpreadRevolutionaryDate::Target'
  => {worker => 'Mastodon::Client'};

use Mastodon::Client;
use Encode qw(encode decode is_utf8);

use Locale::TextDomain 'App-SpreadRevolutionaryDate';
use namespace::autoclean;

has 'instance' => (
  is  => 'ro',
  isa => 'Str',
  required => 1,
);

has 'client_id' => (
  is  => 'ro',
  isa => 'Str',
  required => 1,
);

has 'client_secret' => (
  is  => 'ro',
  isa => 'Str',
  required => 1,
);

has 'access_token' => (
  is  => 'ro',
  isa => 'Str',
  required => 1,
);

=method new

Constructor class method. Takes a hash argument with the following mandatory keys: C<instance>, C<client_id>, C<client_secret>, and C<access_token>, with all values being strings. Authentifies to Mastodon and returns an C<App::SpreadRevolutionaryDate::Target::Mastodon> object.

=cut

around BUILDARGS => sub {
  my ($orig, $class) = @_;

  my $args = $class->$orig(@_);

  $args->{obj} = Mastodon::Client->new(
                  instance        => $args->{instance},
                  client_id       => $args->{client_id},
                  client_secret   => $args->{client_secret},
                  access_token    => $args->{access_token},
                  name            => 'RevolutionaryDate');
  return $args;
};

=method spread

Spreads a message to Mastodon. Takes one mandatory argument: C<$msg> which should be the message to spread as a characters string; and one optional argument: C<test>, which defaults to C<false>, and if C<true> prints the message on standard output instead of spreading on Mastodon.

=cut

sub spread {
  my ($self, $msg, $test, $img) = @_;
  $test //= 0;

  # Multiline message
  $msg =~ s/\\n/\n/g;

  if ($test) {
    $msg = __("Spread on Mastodon: ") . $msg;

    if ($img) {
      $msg .= " with image path: " . $img->{path} . " , alt: " . $img->{alt};
    }

    use open qw(:std :encoding(UTF-8));
    use IO::Handle;
    my $io = IO::Handle->new;
    $io->fdopen(fileno(STDOUT), "w");

    $msg = encode('UTF-8', $msg) if is_utf8($msg);
    $io->say($msg);
  } else {
    my $params;
    if ($img) {
      $img = {path => $img} unless ref($img) && ref($img) eq 'HASH' && $img->{path};
      my $img_alt = $img->{alt} // ucfirst(fileparse($img->{path}, qr/\.[^.]*/));
      $img_alt = encode('UTF-8', $img_alt) if is_utf8($img_alt);
      my $resp_img = $self->obj->upload_media($img->{path}, {description => $img_alt});
      $params->{media_ids} = [$resp_img->{id}] if $resp_img->{id};
    }
    $self->obj->post_status($msg, $params);
  }
}

=head1 SEE ALSO

=over

=item L<spread-revolutionary-date>

=item L<App::SpreadRevolutionaryDate>

=item L<App::SpreadRevolutionaryDate::Config>

=item L<App::SpreadRevolutionaryDate::BlueskyLite>

=item L<App::SpreadRevolutionaryDate::Target>

=item L<App::SpreadRevolutionaryDate::Target::Bluesky>

=item L<App::SpreadRevolutionaryDate::Target::Twitter>

=item L<App::SpreadRevolutionaryDate::Target::Freenode>

=item L<App::SpreadRevolutionaryDate::Target::Freenode::Bot>

=item L<App::SpreadRevolutionaryDate::Target::Liberachat>

=item L<App::SpreadRevolutionaryDate::Target::Liberachat::Bot>

=item L<App::SpreadRevolutionaryDate::MsgMaker>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Calendar>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::fr>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::en>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::it>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::es>

=item L<App::SpreadRevolutionaryDate::MsgMaker::PromptUser>

=item L<App::SpreadRevolutionaryDate::MsgMaker::Telechat>

=back

=cut

no Moose;
__PACKAGE__->meta->make_immutable;

# A module must return a true value. Traditionally, a module returns 1.
# But this module is a revolutionary one, so it discards all old traditions.
# Idea borrowed from Jean Forget's DateTime::Calendar::FrenchRevolutionary.
"Quand le gouvernement viole les droits du peuple,
l'insurrection est pour le peuple le plus sacré
et le plus indispensable des devoirs";
