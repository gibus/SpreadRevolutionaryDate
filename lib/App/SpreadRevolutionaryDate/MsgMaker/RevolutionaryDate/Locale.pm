use 5.014;
use utf8;
package App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale;

# ABSTRACT: Role providing interface for localization of revolutionary date built by <App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate>.

use Moose::Role;

use DateTime;

use Locale::TextDomain 'App-SpreadRevolutionaryDate';
use namespace::autoclean;

has months => (
  is => 'ro',
  isa => 'ArrayRef[Str]',
  required => 1,
);

has decade_days => (
  is => 'ro',
  isa => 'ArrayRef[Str]',
  required => 1,
);

has prefix => (
  is => 'ro',
  isa => 'ArrayRef[Str]',
  required => 1,
);

has suffix => (
  is => 'ro',
  isa => 'Str',
  required => 1,
);

has feast => (
  is => 'ro',
  isa => 'ArrayRef[Str]',
  required => 1,
);

has wikipedia_entries => (
  is => 'ro',
  isa => 'HashRef[HashRef[Str]]',
  required => 1,
);

=method month_name

Returns the name of the month. Takes a DateTime::Calendar::FrenchRevolutionary object as mandatory parameter.

=cut

sub month_name {
    my ($self, $date) = @_;
    return $self->months->[$date->month_0]
}

=method day_name

Returns the name of the day. Takes a DateTime::Calendar::FrenchRevolutionary object as mandatory parameter.

=cut

sub day_name {
    my ($self, $date) = @_;
    return $self->decade_days->[$date->day_of_decade_0];
}

=method feast_short

Returns the feast of the day. Takes a DateTime::Calendar::FrenchRevolutionary object as mandatory parameter.

=cut

sub feast_short {
  my ($self, $date) = @_;
  my $lb = $self->feast->[$date->day_of_year_0];
  $lb =~ s/_/ /g;
  return substr($lb, 1);
}

=method feast_long

Returns the feast of the day in long format (day of xxx). Takes a DateTime::Calendar::FrenchRevolutionary object as mandatory parameter.

=cut

sub feast_long {
  my ($self, $date) = @_;
  my $lb = $self->feast->[$date->day_of_year_0] . $self->suffix;
  $lb =~ s/_/ /g;
  $lb =~ s/^(\d)/$self->prefix->[$1]/e;
  return $lb;
}

=method wikipedia_redirect

Returns the wikipedia entry (the end of the wikipedia url) corresponding to the feast of the day. Takes two mandatory parameters: the month as integer from 0 to 13 (13 is used for complementary days, or "sansculottides"), and the search entry (which should be the feast of the day as returned by L</feast_short>) as a string.

=cut

sub wikipedia_redirect {
  my ($self, $month, $entry) = @_;
  $entry = $self->wikipedia_entries->{$month}->{$entry}
      if    exists $self->wikipedia_entries->{$month}
         && exists $self->wikipedia_entries->{$month}->{$entry};
  return $entry;
}

=head1 DESCRIPTION

This role defines the interface for any class that makes a message to be spread by L<App::SpreadRevolutionaryDate>.

Any class consuming this role is required to implement a C<compute> method, which is called with no parameters, and should return the message to be spread as a string.

This role provides a C<locale> required attribute (defaults to C<'fr'>), which holds the language, defined in language code of L<ISO 639-1 alpha-2|https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes>. Consuming classes are then free to use this C<locale> attribute to localize the message they compute.

=head1 SEE ALSO

=over

=item L<spread-revolutionary-date|https://metacpan.org/pod/distribution/App-SpreadRevolutionaryDate/bin/spread-revolutionary-date>

=item L<App::SpreadRevolutionaryDate>

=item L<App::SpreadRevolutionaryDate::Config>

=item L<App::SpreadRevolutionaryDate::Target>

=item L<App::SpreadRevolutionaryDate::Target::Twitter>

=item L<App::SpreadRevolutionaryDate::Target::Mastodon>

=item L<App::SpreadRevolutionaryDate::Target::Freenode>

=item L<App::SpreadRevolutionaryDate::Target::Freenode::Bot>

=item L<App::SpreadRevolutionaryDate::Target::MsgMaker::RevolutionaryDate>

=item L<App::SpreadRevolutionaryDate::Target::MsgMaker::PromptUser>

=back

=cut

# A module must return a true value. Traditionally, a module returns 1.
# But this module is a revolutionary one, so it discards all old traditions.
# Idea borrowed from Jean Forget's DateTime::Calendar::FrenchRevolutionary.
"Quand le gouvernement viole les droits du peuple,
l'insurrection est pour le peuple le plus sacré
et le plus indispensable des devoirs";
