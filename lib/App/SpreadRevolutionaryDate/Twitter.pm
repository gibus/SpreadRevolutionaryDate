use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
package App::SpreadRevolutionaryDate::Twitter;

# ABSTRACT: Subclass of L<App::SpreadRevolutionaryDate> to handle spreading on Twitter.

use Net::Twitter::Lite::WithAPIv1_1;

=method new

Constructor class method. Takes one mandatory argument: C<$config> which should be an C<App::SpreadRevolutionaryDate::Config> object. Authentifies to Twitter and returns an C<App::SpreadRevolutionaryDate::Twitter> object.

=cut

sub new {
  my $class = shift;
  my $config = shift;
  my $twitter = Net::Twitter::Lite::WithAPIv1_1->new(
                  consumer_key        => $config->twitter_consumer_key,
                  consumer_secret     => $config->twitter_consumer_secret,
                  access_token        => $config->twitter_access_token,
                  access_token_secret => $config->twitter_access_token_secret,
                  user_agent          => 'RevolutionaryDate',
                  ssl                 => 1);
  bless {config => $config, obj => $twitter}, $class;
}

=method spread

Spreads a message to Twitter. Takes one mandatory argument: C<$msg> which should be the message to spread as a characters string. If C<test> option is set the message is printed on standard output and not spread on Twitter.

=cut

sub spread {
  my $self = shift;
  my $msg = shift;
  if ($self->{config}->test) {
    print "Spread to Twitter: $msg\n";
  } else {
    $self->{twitter}->update($msg);
  }
}

1;
