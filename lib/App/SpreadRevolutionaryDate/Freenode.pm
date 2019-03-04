use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
package App::SpreadRevolutionaryDate::Freenode;

# ABSTRACT: Subclass of L<App::SpreadRevolutionaryDate> to handle spreading on Freenode.

use App::SpreadRevolutionaryDate::Freenode::Bot;

=method new

Constructor class method, subclassing C<Bot::BasicBot>. Takes one mandatory argument: C<$config> which should be an C<App::SpreadRevolutionaryDate::Config> object. Returns an C<App::SpreadRevolutionaryDate::Freenode> object.

=cut

sub new {
  my $class = shift;
  my $config = shift;
  bless {config => $config}, $class;
}

=method spread

Spreads a message to Freenode channels configured with the multivalued option C<channels>. Takes one mandatory argument: C<$msg> which should be the message to spread as a characters string. If C<test> option is set the message is spreaded on channels configured with the multivalued option C<test_channels>.

=cut

sub spread {
  my $self = shift;
  my $msg = shift;

  my $port = 6667;
  my $ssl = 0;

  # Switch to SSL if module POE::Component::SSLify is available
  if (eval { require POE::Component::SSLify; 1 }) {
    $port = 6697;
    $ssl = 1;
  }

  my $channels = $self->{config}->test ? $self->{config}->freenode_test_channels : $self->{config}->freenode_channels;

  my $freenode = App::SpreadRevolutionaryDate::Freenode::Bot->new(
    server            => 'irc.freenode.net',
    port              => $port,
    nick              => 'RevolutionaryDate',
    alt_nicks         => ['RevolutionaryCalendar', 'RevolutionarybBot'],
    name              => 'Revolutionary Calendar bot',
    flood             => 1,
    useipv6           => 1,
    ssl               => $ssl,
    charset           => 'utf-8',
    channels          => $channels,
    freenode_nickname => $self->{config}->freenode_nickname,
    freenode_password => $self->{config}->freenode_password,
    msg               => $msg,
  )->run();
}

1;
