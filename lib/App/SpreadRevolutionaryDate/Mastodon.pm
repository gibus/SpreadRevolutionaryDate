use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
package App::SpreadRevolutionaryDate::Mastodon;

use Mastodon::Client;

sub new {
  my $class = shift;
  my $config = shift;
  my $mastodon = Mastodon::Client->new(
                  instance        => $config->mastodon_instance,
                  client_id       => $config->mastodon_client_id,
                  client_secret   => $config->mastodon_client_secret,
                  access_token    => $config->mastodon_access_token,
                  coerce_entities => 1,
                  name            => 'RevolutionaryDate');
  bless {config => $config, obj => $mastodon}, $class;
}

sub spread {
  my $self = shift;
  my $msg = shift;
  if ($self->{config}->test) {
    print "Spread to Mastodon $msg\n";
  } else {
    $self->{obj}->update($msg);
  }
}

1;
