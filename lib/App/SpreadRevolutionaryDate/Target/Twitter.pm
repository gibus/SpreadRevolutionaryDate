use 5.014;
use utf8;
package App::SpreadRevolutionaryDate::Target::Twitter;

# ABSTRACT: Companion class of L<App::SpreadRevolutionaryDate> to handle spreading on Twitter.

use Moose;
with 'App::SpreadRevolutionaryDate::Target' => {class_name => 'Net::Twitter::Lite::WithAPIv1_1'};
use namespace::autoclean;
use Net::Twitter::Lite::WithAPIv1_1;
use Net::OAuth 0.25;

has 'consumer_key' => (
    is  => 'ro',
    isa => 'Str',
    required => 1,
);

has 'consumer_secret' => (
    is  => 'ro',
    isa => 'Str',
    required => 1,
);

has 'access_token' => (
    is  => 'ro',
    isa => 'Str',
    required => 1,
);

has 'access_token_secret' => (
    is  => 'ro',
    isa => 'Str',
    required => 1,
);

=method new

Constructor class method. Takes a hash argument with the following mandatory keys: C<consumer_key>, C<consumer_secret>, C<access_token>, and C<access_token_secret>, with all values being strings. Authentifies to Twitter and returns an C<App::SpreadRevolutionaryDate::Target::Twitter> object.

=cut

around BUILDARGS => sub {
  my $orig = shift;
  my $class = shift;
  my $args = $class->$orig(@_);

  $args->{obj} = Net::Twitter::Lite::WithAPIv1_1->new(
                  consumer_key        => $args->{consumer_key},
                  consumer_secret     => $args->{consumer_secret},
                  access_token        => $args->{access_token},
                  access_token_secret => $args->{access_token_secret},
                  user_agent          => 'RevolutionaryDate',
                  ssl                 => 1);
  return $args;
};

=method spread

Spreads a message to Twitter. Takes one mandatory argument: C<$msg> which should be the message to spread as a characters string; and one optional argument: C<test>, which defaults to C<false>, and if C<true> prints the message on standard output instead of spreading on Twitter.

=cut

sub spread {
  my $self = shift;
  my $msg = shift;
  my $test = shift // 0;
  if ($test) {
    print "Spread to Twitter: $msg\n";
  } else {
    $self->obj->update($msg);
  }
}

=head1 SEE ALSO

=over

=item L<spread-revolutionary-date|https://metacpan.org/pod/distribution/App-SpreadRevolutionaryDate/bin/spread-revolutionary-date>

=item L<App::SpreadRevolutionaryDate>

=item L<App::SpreadRevolutionaryDate::Config>

=item L<App::SpreadRevolutionaryDate::Target::Mastodon>

=item L<App::SpreadRevolutionaryDate::Target::Freenode>

=item L<App::SpreadRevolutionaryDate::Target::Freenode::Bot>

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
