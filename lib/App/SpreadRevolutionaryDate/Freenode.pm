use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
package App::SpreadRevolutionaryDate::Freenode;

# ABSTRACT: Subclass of L<App::SpreadRevolutionaryDate> to handle spreading on Freenode.

use Moose;
use namespace::autoclean;
use App::SpreadRevolutionaryDate::Freenode::Bot;
use POE;

has 'obj' => (
    is  => 'ro',
    isa => 'App::SpreadRevolutionaryDate::Freenode::Bot',
    required => 1,
);

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

Constructor class method, subclassing C<Bot::BasicBot>. Takes a hash argument with the following mandatory keys: C<nickname>, C<password>, and C<channels>, with all values being strings. Returns an C<App::SpreadRevolutionaryDate::Freenode> object.

=cut

around BUILDARGS => sub {
  my $orig = shift;
  my $class = shift;

  my $port = 6667;
  my $ssl = 0;

  # Switch to SSL if module POE::Component::SSLify is available
  if (eval { require POE::Component::SSLify; 1 }) {
    $port = 6697;
    $ssl = 1;
  }

  my $args = $class->$orig(@_);

  $args->{obj} = App::SpreadRevolutionaryDate::Freenode::Bot->new(
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
  my $self = shift;
  my $msg = shift;

  $self->obj->msg($msg);
  $self->obj->run();
  POE::Kernel->run();
}

=head1 SEE ALSO

=over

=item L<spread-revolutionary-date|https://metacpan.org/pod/distribution/App-SpreadRevolutionaryDate/bin/spread-revolutionary-date>

=item L<App::SpreadRevolutionaryDate>

=item L<App::SpreadRevolutionaryDate::Config>

=item L<App::SpreadRevolutionaryDate::Twitter>

=item L<App::SpreadRevolutionaryDate::Mastodon>

=item L<App::SpreadRevolutionaryDate::Freenode::Bot>

=back

=cut

1;
