use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
package App::SpreadRevolutionaryDate::Twitter;

use Net::Twitter::Lite::WithAPIv1_1;

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
