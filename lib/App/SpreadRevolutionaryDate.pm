use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
package App::SpreadRevolutionaryDate;

# ABSTRACT: Spread date and time from Revolutionary (Republican) Calendar on Twitter, Mastodon and Freenode.

use App::SpreadRevolutionaryDate::Config;
use App::SpreadRevolutionaryDate::Twitter;
use App::SpreadRevolutionaryDate::Mastodon;
use App::SpreadRevolutionaryDate::Freenode;
use DateTime::Calendar::FrenchRevolutionary;

=method new

Constructor class method. Takes one optional argument: C<$filename> which should be the file path or an opened file handle of your configuration path, defaults to C<~/.config/spread-revolutionary-date/spread-revolutionary-date.conf> or C<~/.spread-revolutionary-date.conf>. Returns an C<App::SpreadRevolutionaryDate> object.

=cut

sub new {
  my $class = shift;
  my $filename = shift;
  my $config = App::SpreadRevolutionaryDate::Config->new;

  $config->parse_file($filename);
  $config->parse_command_line;
  
  my $self = {config => $config};

  if (!$self->{config}->twitter && !$self->{config}->mastodon && !$self->{config}->freenode) {
    $self->{config}->twitter(1);
    $self->{config}->mastodon(1);
    $self->{config}->freenode(1);
  }

  if ($self->{config}->twitter) {
    if ($self->{config}->check_twitter) {
      $self->{twitter} = App::SpreadRevolutionaryDate::Twitter->new($self->{config});
    }
  }

  if ($self->{config}->mastodon) {
    if ($self->{config}->check_mastodon) {
      $self->{mastodon} = App::SpreadRevolutionaryDate::Mastodon->new($self->{config});
    }
  }

  if ($self->{config}->freenode) {
    if ($self->{config}->check_freenode) {
      $self->{freenode} = App::SpreadRevolutionaryDate::Freenode->new($self->{config});
    }
  }

  bless $self, $class;
  return $self;
}

=method spread

Spreads calendar date to configured targets. Takes no argument.

=cut

sub spread {
  my $self = shift;

  my $now = DateTime->today->set(hour => 3, minute => 8, second => 56);
  my $msg = DateTime::Calendar::FrenchRevolutionary->from_object(object => $now)->strftime("Nous sommes le %A, %d %B de l'An %EY (%Y) de la Révolution, %Ej, il est %T!");

  $self->{twitter}->spread($msg) if $self->{twitter};
  $self->{mastodon}->spread($msg) if $self->{mastodon};
  $self->{freenode}->spread($msg) if $self->{freenode};
}

1;
