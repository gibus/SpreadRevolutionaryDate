use 5.014;
use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
package App::SpreadRevolutionaryDate;

# ABSTRACT: Spread date and time from Revolutionary (Republican) Calendar on Twitter, Mastodon and Freenode.

use Moose;
use namespace::autoclean;
use App::SpreadRevolutionaryDate::Config;
use App::SpreadRevolutionaryDate::Target::Twitter;
use App::SpreadRevolutionaryDate::Target::Mastodon;
use App::SpreadRevolutionaryDate::Target::Freenode;
use DateTime::Calendar::FrenchRevolutionary;
use URI::Escape;

has 'config' => (
    is  => 'ro',
    isa => 'App::SpreadRevolutionaryDate::Config',
    required => 1,
);

has 'twitter' => (
    is  => 'ro',
    isa => 'App::SpreadRevolutionaryDate::Target::Twitter',
);

has 'mastodon' => (
    is  => 'ro',
    isa => 'App::SpreadRevolutionaryDate::Target::Mastodon',
);

has 'freenode' => (
    is  => 'ro',
    isa => 'App::SpreadRevolutionaryDate::Target::Freenode',
);

=method new

Constructor class method. Takes one optional argument: C<$filename> which should be the file path of, or an opened file handle on your configuration file, defaults to C<~/.config/spread-revolutionary-date/spread-revolutionary-date.conf> or C<~/.spread-revolutionary-date.conf>. This is only used for testing, when custom configuration file is needed. You can safely leave this optional argument unset. Returns an C<App::SpreadRevolutionaryDate> object.

=cut

around BUILDARGS => sub {
  my $orig = shift;
  my $class = shift;
  my $filename = shift;
  my $config = App::SpreadRevolutionaryDate::Config->new;

  $config->parse_file($filename);
  $config->parse_command_line;

  my $args = $class->$orig(config => $config);

  if (!$args->{config}->twitter && !$args->{config}->mastodon && !$args->{config}->freenode) {
    $args->{config}->twitter(1);
    $args->{config}->mastodon(1);
    $args->{config}->freenode(1);
  }

  if ($args->{config}->twitter) {
    if ($args->{config}->check_twitter) {
      my %twitter_args = $args->{config}->get_target_arguments('twitter');
      $args->{twitter} = App::SpreadRevolutionaryDate::Target::Twitter->new(%twitter_args);
    } else {
      die "Cannot spread on Twitter, configuraton parameters missing\n";
    }
  }

  if ($args->{config}->mastodon) {
    if ($args->{config}->check_mastodon) {
      my %mastodon_args = $args->{config}->get_target_arguments('mastodon');
      $args->{mastodon} = App::SpreadRevolutionaryDate::Target::Mastodon->new(%mastodon_args);
    } else {
      die "Cannot spread on Mastodon, configuraton parameters missing\n";
    }
  }

  if ($args->{config}->freenode) {
    if ($args->{config}->check_freenode) {
      my %freenode_args = $args->{config}->get_target_arguments('freenode');
      $args->{freenode} = App::SpreadRevolutionaryDate::Target::Freenode->new(%freenode_args);
    } else {
      die "Cannot spread on Freenode, configuraton parameters missing\n";
    }
  }

  return $args;
};

=method spread

Spreads calendar date to configured targets. Takes no argument.

=cut

sub spread {
  my $self = shift;

  my $msg = $self->compute();
  $self->twitter->spread($msg, $self->config->test) if $self->config->twitter;
  $self->mastodon->spread($msg, $self->config->test) if $self->config->mastodon;
  $self->freenode->spread($msg) if $self->config->freenode;
}

=method compute

Computes revolutionary date. Takes no argument. Returns message as string, ready to be spread.

=cut

sub compute {
  my $self = shift;

  # As of DateTime::Calendar::FrenchRevolutionary 0.14
  # locale is limited to 'en' or 'fr', defaults to 'fr'
  my $locale = $self->config->locale || 'fr';
  $locale = 'fr' unless $locale eq 'en';

  my $revolutionary = $self->config->acab ?
      DateTime::Calendar::FrenchRevolutionary->now->set(hour => 1, minute => 31, second => 20, locale => $locale)
    : DateTime::Calendar::FrenchRevolutionary->now;
  my $msg = $locale eq 'fr' ? $revolutionary->strftime("Nous sommes le %A, %d %B de l'An %EY (%Y) de la Révolution, %Ej, il est %T! https://$locale.wikipedia.org/wiki/!!%Oj!!") : $revolutionary->strftime("We are %A, %d %B of Revolution Year %EY (%Y), %Ej, it is %T! https://$locale.wikipedia.org/wiki/!!%Oj!!");
  $msg =~ s/!!([^!]+)!!/uri_escape($1)/e;

  return $msg
}

=head1 SEE ALSO

=over

=item L<spread-revolutionary-date|https://metacpan.org/pod/distribution/App-SpreadRevolutionaryDate/bin/spread-revolutionary-date>

=item L<App::SpreadRevolutionaryDate::Config>

=item L<App::SpreadRevolutionaryDate::Target::Twitter>

=item L<App::SpreadRevolutionaryDate::Target::Mastodon>

=item L<App::SpreadRevolutionaryDate::Target::Freenode>

=item L<App::SpreadRevolutionaryDate::Target::Freenode::Bot>

=back

=cut

no Moose;
__PACKAGE__->meta->make_immutable;
