use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
package App::SpreadRevolutionaryDate::Freenode::Bot;

# ABSTRACT: Subclass overriding L<Bot::BasicBit> to post a message on some Freenode channels

use Moose;
use MooseX::NonMoose;
extends 'Bot::BasicBot';

has 'nb_said' => (
    traits  => ['Counter'],
    is  => 'rw',
    isa => 'Num',
    default => 0,
    handles => {
        inc_said   => 'inc',
    },
);

has 'nb_ticks' => (
    traits  => ['Counter'],
    is  => 'rw',
    isa => 'Num',
    default => 0,
    handles => {
        inc_ticks   => 'inc',
    },
);

sub connected {
  my $self = shift;
  $self->say({who => 'NickServ', channel => 'msg', body => 'IDENTIFY ' . $self->{freenode_nickname} . ' ' . $self->{freenode_password}});
}

sub said {
  my $self = shift;
  my $message = shift;
  $self->nb_said(1) if ($message->{who} eq 'NickServ' && $message->{body} =~ /^You are now identified for/);
  return;
}

sub tick {
  my $self = shift;
  if ($self->nb_said) {
    if ($self->nb_said > scalar($self->channels)) {
      $self->shutdown;
    }
    foreach my $channel ($self->channels) {
      $self->say({channel => $channel, body => $self->{msg}});
      $self->inc_said;
    }
  }

  $self->inc_ticks;
  $self->shutdown if ($self->nb_ticks > 10);

  return 5;
}

sub log {
  # do nothing!
}

=head1 SEE ALSO

=over

=item L<spread-revolutionary-date|https://metacpan.org/pod/distribution/App-SpreadRevolutionaryDate/bin/spread-revolutionary-date>

=item L<App::SpreadRevolutionaryDate>

=item L<App::SpreadRevolutionaryDate::Config>

=item L<App::SpreadRevolutionaryDate::Twitter>

=item L<App::SpreadRevolutionaryDate::Mastodon>

=item L<App::SpreadRevolutionaryDate::Freenode>

=back

=cut

no Moose;
__PACKAGE__->meta->make_immutable;
