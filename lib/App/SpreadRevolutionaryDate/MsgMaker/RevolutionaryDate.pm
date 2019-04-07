use 5.014;
use utf8;
package App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate;

# ABSTRACT: MsgMaker class for L<App::SpreadRevolutionaryDate> to build message with revolutionary date

use Moose;
with 'App::SpreadRevolutionaryDate::MsgMaker';

use App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Calendar;

use Locale::TextDomain 'App-SpreadRevolutionaryDate';
use namespace::autoclean;

has 'acab' => (
    is  => 'ro',
    isa => 'Bool',
    required => 1,
    default => 0,
);

has 'wikipedia_link' => (
    is  => 'ro',
    isa => 'Bool',
    required => 1,
    default => 1,
);

around BUILDARGS => sub {
  my ($orig, $class, %args) = @_;

  $args{locale} = 'fr'
    unless   $args{locale}
          && grep { $args{locale} eq $_ } ('en', 'it');
  return $class->$orig(%args);
};

=method compute

Computes revolutionary date. Takes no argument. Returns message as string, ready to be spread.

=cut

sub compute {
  my $self = shift;

  # As of App::SpreadRevolutionaryDate 0.11
  # locale is limited to 'fr', 'en' or 'it', defaults to 'fr'
  # forced to 'fr' for any other value
  my $revolutionary = $self->acab ?
      App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Calendar->now->set(hour => 1, minute => 31, second => 20, locale => $self->locale)
    : App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Calendar->now->set(locale => $self->locale);

  my $msg = __x("We are {day_name}, {day} {month} of Revolution year {roman_year} ({year}), {feast_long}, it is {time}!",
      day_name   => $revolutionary->day_name,
      day        => $revolutionary->day,
      month      => $revolutionary->month_name,
      roman_year => $revolutionary->strftime("%EY"),
      year       => $revolutionary->year,
      feast_long => $revolutionary->feast_long,
      time       => $revolutionary->hms,
  );

  if ($self->wikipedia_link) {
    use URI::Escape;
    my $entry = $revolutionary->locale->wikipedia_redirect($revolutionary->month, $revolutionary->feast_short);
    $msg .= ' https://' . $self->locale . '.wikipedia.org/wiki/' . uri_escape_utf8($entry);
  }

  return $msg
}

=head1 SEE ALSO

=over

=item L<spread-revolutionary-date>

=item L<App::SpreadRevolutionaryDate>

=item L<App::SpreadRevolutionaryDate::Config>

=item L<App::SpreadRevolutionaryDate::Target>

=item L<App::SpreadRevolutionaryDate::Target::Twitter>

=item L<App::SpreadRevolutionaryDate::Target::Mastodon>

=item L<App::SpreadRevolutionaryDate::Target::Freenode>

=item L<App::SpreadRevolutionaryDate::Target::Freenode::Bot>

=item L<App::SpreadRevolutionaryDate::Target::MsgMaker>

=item L<App::SpreadRevolutionaryDate::Target::MsgMaker::RevolutionaryDate::Calendar>

=item L<App::SpreadRevolutionaryDate::Target::MsgMaker::RevolutionaryDate::Locale>

=item L<App::SpreadRevolutionaryDate::Target::MsgMaker::RevolutionaryDate::Locale::fr>

=item L<App::SpreadRevolutionaryDate::Target::MsgMaker::RevolutionaryDate::Locale::en>

=item L<App::SpreadRevolutionaryDate::Target::MsgMaker::RevolutionaryDate::Locale::it>

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
