use 5.014;
use utf8;
package App::SpreadRevolutionaryDate::Target::Freenode;

# ABSTRACT: Target class for L<App::SpreadRevolutionaryDate> to handle spreading on Freenode.

use Moose;
with 'App::SpreadRevolutionaryDate::Target'
  => {worker => 'App::SpreadRevolutionaryDate::Target::Freenode::Bot'};

use App::SpreadRevolutionaryDate::Target::Freenode::Bot;
use POE;

use Locale::TextDomain 'App-SpreadRevolutionaryDate';
use namespace::autoclean;

has 'nickname' => (
    is  => 'ro',
    isa => 'Str',
    required => 1,
);

has 'password' => (
    is  => 'ro',
    isa => 'Str',
    required => 1,
);

has 'channels' => (
    is  => 'ro',
    isa => 'ArrayRef[Str]',
    required => 1,
);

=method new

Constructor class method, subclassing C<Bot::BasicBot>. Takes a hash argument with the following mandatory keys: C<nickname>, C<password>, and C<channels>, with all values being strings. Returns an C<App::SpreadRevolutionaryDate::Target::Freenode> object.

=cut

around BUILDARGS => sub {
  my ($orig, $class) = @_;

  my $port = 6667;
  my $ssl = 0;

  # Switch to SSL if module POE::Component::SSLify is available
  if (eval { require POE::Component::SSLify; 1 }) {
    $port = 6697;
    $ssl = 1;
  }

  my $args = $class->$orig(@_);

  $args->{obj} = App::SpreadRevolutionaryDate::Target::Freenode::Bot->new(
    server            => 'irc.freenode.net',
    port              => $port,
    nick              => 'RevolutionaryDate',
    alt_nicks         => ['RevolutionaryCalendar', 'RevolutionarybBot'],
    name              => 'Revolutionary Calendar bot',
    flood             => 1,
    useipv6           => 1,
    ssl               => $ssl,
    charset           => 'utf-8',
    channels          => $args->{channels},
    freenode_nickname => $args->{nickname},
    freenode_password => $args->{password},
    msg               => '',
    no_run            => 1,
  );

  return $args;
};

=method spread

Spreads a message to Freenode channels configured with the multivalued option C<channels>.

=cut

sub spread {
  my ($self, $msg) = @_;

  $self->obj->msg($msg);
  $self->obj->run;
  POE::Kernel->run();
}

=head1 SEE ALSO

=over

=item L<spread-revolutionary-date>

=item L<App::SpreadRevolutionaryDate>

=item L<App::SpreadRevolutionaryDate::Config>

=item L<App::SpreadRevolutionaryDate::Target>

=item L<App::SpreadRevolutionaryDate::Target::Twitter>

=item L<App::SpreadRevolutionaryDate::Target::Mastodon>

=item L<App::SpreadRevolutionaryDate::Target::Freenode::Bot>

=item L<App::SpreadRevolutionaryDate::MsgMaker>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Calendar>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::fr>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::en>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::it>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::es>

=item L<App::SpreadRevolutionaryDate::MsgMaker::PromptUser>

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
