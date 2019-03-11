use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
package App::SpreadRevolutionaryDate::Freenode;

# ABSTRACT: Subclass of L<App::SpreadRevolutionaryDate> to handle spreading on Freenode.

use Moose;
use namespace::autoclean;
use App::SpreadRevolutionaryDate::Freenode::Bot;

has 'config' => (
    is  => 'ro',
    isa => 'App::SpreadRevolutionaryDate::Config',
    required => 1,
);

=method new

Constructor class method, subclassing C<Bot::BasicBot>. Takes one mandatory argument: C<$config> which should be an C<App::SpreadRevolutionaryDate::Config> object. Returns an C<App::SpreadRevolutionaryDate::Freenode> object.

=cut

around BUILDARGS => sub {
  my $orig = shift;
  my $class = shift;
  my $config = shift;
  return $class->$orig(config => $config);
};

=method spread

Spreads a message to Freenode channels configured with the multivalued option C<channels>. Takes one mandatory argument: C<$msg> which should be the message to spread as a characters string. If C<test> option is set the message is spreaded on channels configured with the multivalued option C<test_channels>. Takes also one optional boolean argument, if true (default) authentication and spreading to Freenode is performed, otherwise, you've got to run C<use POE; POE::Kernel->run();> to do so. This is only used for testing, when multiple bots are needed. You can safely leave this optional argument unset.

=cut

sub spread {
  my $self = shift;
  my $msg = shift;
  my $no_run = shift // 1;
  $no_run = !$no_run;

  my $port = 6667;
  my $ssl = 0;

  # Switch to SSL if module POE::Component::SSLify is available
  if (eval { require POE::Component::SSLify; 1 }) {
    $port = 6697;
    $ssl = 1;
  }

  my $channels = $self->config->test ? $self->config->freenode_test_channels : $self->config->freenode_channels;

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
    freenode_nickname => $self->config->freenode_nickname,
    freenode_password => $self->config->freenode_password,
    msg               => $msg,
    no_run            => $no_run,
  )->run();
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
