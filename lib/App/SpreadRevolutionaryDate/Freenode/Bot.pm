use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
package App::SpreadRevolutionaryDate::Freenode::Bot;

# ABSTRACT: Subclass overriding L<Bot::BasicBit> to post a message on some Freenode channels

use parent 'Bot::BasicBot';

use File::Spec;
local *STDERR;
open STDERR, '>', File::Spec->devnull;
 
our $said = 0;
our $nb_ticks = 0;

sub connected {
  my $self = shift;
  $self->say({who => 'NickServ', channel => 'msg', body => 'IDENTIFY ' . $self->{freenode_nickname} . ' ' . $self->{freenode_password}});
}

sub said {
  my $self = shift;
  my $message = shift;
  $said=1 if ($message->{who} eq 'NickServ' && $message->{body} =~ /^You are now identified for/);
  return;
}

sub tick {
  my $self = shift;
  if ($said) {
    if ($said > scalar($self->channels)) {
      $self->shutdown;
    }
    foreach my $channel ($self->channels) {
      $self->say({channel => $channel, body => $self->{msg}});
      $said++;
    }
  }

  $nb_ticks++;
  $self->shutdown if ($nb_ticks > 10);

  return 5;
}

1;
