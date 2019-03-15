use 5.010;
use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
package App::SpreadRevolutionaryDate;

# ABSTRACT: Spread date and time from Revolutionary (Republican) Calendar on Twitter, Mastodon and Freenode.

use Moose;
use namespace::autoclean;
use App::SpreadRevolutionaryDate::Config;
use App::SpreadRevolutionaryDate::Twitter;
use App::SpreadRevolutionaryDate::Mastodon;
use App::SpreadRevolutionaryDate::Freenode;
use DateTime::Calendar::FrenchRevolutionary;
use URI::Escape;

has 'config' => (
    is  => 'ro',
    isa => 'App::SpreadRevolutionaryDate::Config',
    required => 1,
);

has 'twitter' => (
    is  => 'ro',
    isa => 'App::SpreadRevolutionaryDate::Twitter',
);

has 'mastodon' => (
    is  => 'ro',
    isa => 'App::SpreadRevolutionaryDate::Mastodon',
);

has 'freenode' => (
    is  => 'ro',
    isa => 'App::SpreadRevolutionaryDate::Freenode',
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
      $args->{twitter} = App::SpreadRevolutionaryDate::Twitter->new($args->{config});
    } else {
      die "Cannot spread on Twitter, configuraton parameters missing\n";
    }
  }

  if ($args->{config}->mastodon) {
    if ($args->{config}->check_mastodon) {
      $args->{mastodon} = App::SpreadRevolutionaryDate::Mastodon->new($args->{config});
    } else {
      die "Cannot spread on Mastodon, configuraton parameters missing\n";
    }
  }

  if ($args->{config}->freenode) {
    if ($args->{config}->check_freenode) {
      $args->{freenode} = App::SpreadRevolutionaryDate::Freenode->new($args->{config});
    } else {
      die "Cannot spread on Freenode, configuraton parameters missing\n";
    }
  }

  return $args;
};

=method spread

Spreads calendar date to configured targets. Takes one optional boolean argument, if true (default) authentication and spreading to Freenode is performed, otherwise, you've got to run C<use POE; POE::Kernel-E<gt>run();> to do so. This is only used for testing, when multiple bots are needed. You can safely leave this optional argument unset.

=cut

sub spread {
  my $self = shift;
  my $no_run = shift // 1;
  $no_run = !$no_run;

  # As of DateTime::Calendar::FrenchRevolutionary 0.14
  # locale is limited to 'en' or 'fr', defaults to 'fr'
  my $locale = $self->config->locale || 'fr';
  $locale = 'fr' unless $locale eq 'en';

  my $revolutionary = $self->config->acab ?
      DateTime::Calendar::FrenchRevolutionary->now->set(hour => 1, minute => 31, second => 20, locale => $locale)
    : DateTime::Calendar::FrenchRevolutionary->now;
  my $msg = $locale eq 'fr' ? $revolutionary->strftime("Nous sommes le %A, %d %B de l'An %EY (%Y) de la Révolution, %Ej, il est %T!\nhttps://fr.wikipedia.org/wiki/!!%Oj!!") : $revolutionary->strftime("We are %A, %d %B of Revolution Year %EY (%Y), %Ej, it is %T!");
  $msg =~ s/!!([^!]+)!!/uri_escape($1)/e;

  $self->twitter->spread($msg) if $self->config->twitter;
  $self->mastodon->spread($msg) if $self->config->mastodon;
  $self->freenode->spread($msg, $no_run) if $self->config->freenode;
}

=head1 SEE ALSO

=over

=item L<spread-revolutionary-date|https://metacpan.org/pod/distribution/App-SpreadRevolutionaryDate/bin/spread-revolutionary-date>

=item L<App::SpreadRevolutionaryDate::Config>

=item L<App::SpreadRevolutionaryDate::Twitter>

=item L<App::SpreadRevolutionaryDate::Mastodon>

=item L<App::SpreadRevolutionaryDate::Freenode>

=item L<App::SpreadRevolutionaryDate::Freenode::Bot>

=back

=cut

no Moose;
__PACKAGE__->meta->make_immutable;
