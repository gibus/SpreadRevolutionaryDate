use 5.014;
use utf8;
package App::SpreadRevolutionaryDate;

# ABSTRACT: Spread date and time from Revolutionary (Republican) Calendar on Twitter, Mastodon and Freenode.

use Moose;
use namespace::autoclean;
use App::SpreadRevolutionaryDate::Config;
use DateTime::Calendar::FrenchRevolutionary;
use URI::Escape;
use Class::Load ':all';

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
  my ($orig, $class, $filename) = @_;

  my $config = App::SpreadRevolutionaryDate::Config->new($filename);

  return $class->$orig(config => $config, targets => {});
};

=method BUILD

Initialises the internal C<App::SpreadRevolutionaryDate> object. This is where all targets objets are built, and authentication is attempted on each of them.

=cut

sub BUILD {
  my $self = shift;

  foreach my $target (@{$self->config->targets}) {
    my $target_class = 'App::SpreadRevolutionaryDate::Target::' . ucfirst(lc($target));
    try_load_class($target_class)
      or die "Cannot import target class $target_class for target $target\n";
    load_class($target_class);
    my %target_args = $self->config->get_target_arguments($target);
    $self->targets->{$target} = $target_class->new(%target_args);
  }
}

=method spread

Spreads calendar date to configured targets. Takes no argument.

=cut

sub spread {
  my $self = shift;

  my $msg = $self->compute();
  foreach my $target (@{$self->config->targets}) {
    $self->targets->{$target}->spread($msg, $self->config->test);
  }
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
    : DateTime::Calendar::FrenchRevolutionary->now->set(locale => $locale);

  my $msg = $locale eq 'fr' ?
      $revolutionary->strftime("Nous sommes le %A, %d %B de l'An %EY (%Y) de la Révolution, %Ej, il est %T! https://$locale.wikipedia.org/wiki/!!%Oj!!")
    : $revolutionary->strftime("We are %A, %d %B of Revolution Year %EY (%Y), %Ej, it is %T! https://$locale.wikipedia.org/wiki/!!%Oj!!");

  $msg =~ s/!!([^!]+)!!/uri_escape($1)/e;

  return $msg
}

=head1 SEE ALSO

=over

=item L<spread-revolutionary-date|https://metacpan.org/pod/distribution/App-SpreadRevolutionaryDate/bin/spread-revolutionary-date>

=item L<App::SpreadRevolutionaryDate::Config>

=item L<App::SpreadRevolutionaryDate::Target>

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
