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
use DateTime::Calendar::FrenchRevolutionary;
use URI::Escape;

has 'config' => (
    is  => 'ro',
    isa => 'App::SpreadRevolutionaryDate::Config',
    required => 1,
);

has 'targets' => (
    is  => 'rw',
    isa => 'HashRef[Object]',
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

  my $args = $class->$orig(config => $config, targets => {});

  if (!$args->{config}->twitter && !$args->{config}->mastodon && !$args->{config}->freenode) {
    $args->{config}->twitter(1);
    $args->{config}->mastodon(1);
    $args->{config}->freenode(1);
  }

  if ($args->{config}->twitter) {
    unless ($args->{config}->check_twitter) {
      die "Cannot spread on Twitter, configuraton parameters missing\n";
    }
  }

  if ($args->{config}->mastodon) {
    unless ($args->{config}->check_mastodon) {
      die "Cannot spread on Mastodon, configuraton parameters missing\n";
    }
  }

  if ($args->{config}->freenode) {
    unless ($args->{config}->check_freenode) {
      die "Cannot spread on Freenode, configuraton parameters missing\n";
    }
  }

  return $args;
};

=method BUILD

Initialises the internal C<App::SpreadRevolutionaryDate> object. This is where all targets objets are built, and authentication is attempted on each of them.

=cut

sub BUILD {
  my $self = shift;

  if ($self->config->twitter) {
    require App::SpreadRevolutionaryDate::Target::Twitter;
    my %twitter_args = $self->config->get_target_arguments('twitter');
    $self->targets->{twitter} = App::SpreadRevolutionaryDate::Target::Twitter->new(%twitter_args);
  }

  if ($self->config->mastodon) {
    require App::SpreadRevolutionaryDate::Target::Mastodon;
    my %mastodon_args = $self->config->get_target_arguments('mastodon');
    $self->targets->{mastodon} = App::SpreadRevolutionaryDate::Target::Mastodon->new(%mastodon_args);
  }

  if ($self->config->freenode) {
    require App::SpreadRevolutionaryDate::Target::Freenode;
    my %freenode_args = $self->config->get_target_arguments('freenode');
    $self->targets->{freenode} = App::SpreadRevolutionaryDate::Target::Freenode->new(%freenode_args);
  }
}

=method spread

Spreads calendar date to configured targets. Takes no argument.

=cut

sub spread {
  my $self = shift;

  my $msg = $self->compute();
  $self->targets->{twitter}->spread($msg, $self->config->test) if $self->config->twitter;
  $self->targets->{mastodon}->spread($msg, $self->config->test) if $self->config->mastodon;
  $self->targets->{freenode}->spread($msg) if $self->config->freenode;
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

# A module must return a true value. Traditionally, a module returns 1.
# But this module is a revolutionary one, so it discards all old traditions.
# Idea borrowed from Jean Forget's DateTime::Calendar::FrenchRevolutionary.
"Quand le gouvernement viole les droits du peuple,
l'insurrection est pour le peuple le plus sacré
et le plus indispensable des devoirs";
