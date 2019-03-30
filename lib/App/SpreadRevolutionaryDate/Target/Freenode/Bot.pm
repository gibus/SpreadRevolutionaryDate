use 5.014;
use utf8;
package App::SpreadRevolutionaryDate::Target::Freenode::Bot;

# ABSTRACT: Subclass overriding L<Bot::BasicBot> to post a message on some Freenode channels

use Moose;
use MooseX::NonMoose;
extends 'Bot::BasicBot';

use Locale::TextDomain 'App-SpreadRevolutionaryDate';
use namespace::autoclean;

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

has 'msg' => (
  is => 'rw',
  isa => 'Str',
  default => '',
);

sub connected {
  my $self = shift;

  $self->say({who => 'NickServ', channel => 'msg', body => 'IDENTIFY ' . $self->{freenode_nickname} . ' ' . $self->{freenode_password}});
}

sub said {
  my ($self, $message) = @_;

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

=item L<App::SpreadRevolutionaryDate::Target>

=item L<App::SpreadRevolutionaryDate::Target::Twitter>

=item L<App::SpreadRevolutionaryDate::Target::Mastodon>

=item L<App::SpreadRevolutionaryDate::Target::Freenode>

=item L<App::SpreadRevolutionaryDate::Target::MsgMaker>

=item L<App::SpreadRevolutionaryDate::Target::MsgMaker::RevolutionaryDate>

=item L<App::SpreadRevolutionaryDate::Target::MsgMaker::PromptUser>

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
