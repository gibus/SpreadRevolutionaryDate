use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
package App::SpreadRevolutionaryDate::Freenode;

use parent 'Bot::BasicBot';

use File::Spec;
open STDERR, '>', File::Spec->devnull;
 
our $said = 0;

sub connected {
  my $self = shift;
  $self->say({who => 'NickServ', channel => 'msg', body => 'IDENTIFY ' . $self->{config}->freenode_nickname . ' ' . $self->{config}->freenode_password});
}

sub said {
  my $self = shift;
  my $message = shift;
  $said=1 if ($message->{who} eq 'NickServ' && $message->{body} =~ /^You are now identified for/);
}

sub tick {
  my $self = shift;
  if ($said) {
    if ($said > scalar($self->channels)) {
      exit;
    }
    foreach my $channel ($self->channels) {
      $self->say({channel => $channel, body => $self->{msg}});
      $said++;
    }
  }
  return 5;
}

sub new {
  my $class = shift;
  my $config = shift;
  my %opts = (
    server    => 'irc.freenode.net',
    port      => '6667',
    nick      => 'RevolutionaryDate',
    alt_nicks => ['RevolutionaryCalendar', 'RevolutionarybBot'],
    name      => 'Revolutionary Calendar bot',
    flood     => 1,
    useipv6   => 1,
    ssl       => 1,
    charset   => 'utf-8',
  );
  my $freenode = Bot::BasicBot->new(%opts);
  bless {obj => $freenode, config => $config}, $class;
}

sub spread {
  my $self = shift;
  my $msg = shift;
  $self->channels($self->{config}->test ? $self->{config}->freenode_test_channels : $self->{config}->freenode_channels);
  $self->msg($msg);
  $self->run();
}

1;
