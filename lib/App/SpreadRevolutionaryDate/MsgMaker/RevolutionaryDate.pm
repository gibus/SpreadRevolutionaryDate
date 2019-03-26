use 5.014;
use utf8;
package App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate;

# ABSTRACT: MsgMaker class for L<App::SpreadRevolutionaryDate> to build message with revolutionary date

use Moose;
with 'App::SpreadRevolutionaryDate::MsgMaker';

use namespace::autoclean;
use URI::Escape;

has 'acab' => (
    is  => 'ro',
    isa => 'Bool',
    required => 1,
    default => 0,
);

around BUILDARGS => sub {
  my ($orig, $class, %args) = @_;

  $args{locale} = 'fr' unless $args{locale} && $args{locale} eq 'en';
  return $class->$orig(%args);
};

=method compute

Computes revolutionary date. Takes no argument. Returns message as string, ready to be spread.

=cut

sub compute {
  my $self = shift;

  # As of DateTime::Calendar::FrenchRevolutionary 0.14
  # locale is limited to 'en' or 'fr', defaults to 'fr'
  my $revolutionary = $self->acab ?
      DateTime::Calendar::FrenchRevolutionary->now->set(hour => 1, minute => 31, second => 20, locale => $self->locale)
    : DateTime::Calendar::FrenchRevolutionary->now->set(locale => $self->locale);

  my $msg = $self->locale eq 'fr' ?
      $revolutionary->strftime("Nous sommes le %A, %d %B de l'An %EY (%Y) de la Révolution, %Ej, il est %T! https://" . $self->locale . ".wikipedia.org/wiki/!!%Oj!!")
    : $revolutionary->strftime("We are %A, %d %B of Revolution Year %EY (%Y), %Ej, it is %T! https://" . $self->locale . ".wikipedia.org/wiki/!!%Oj!!");

  $msg =~ s/!!([^!]+)!!/uri_escape($1)/e;

  return $msg
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

=item L<App::SpreadRevolutionaryDate::Target::Freenode::Bot>

=item L<App::SpreadRevolutionaryDate::Target::MsgMaker>

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
