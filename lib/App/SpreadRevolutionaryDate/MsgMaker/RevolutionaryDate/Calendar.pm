use 5.014;
use utf8;
package App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Calendar;

# ABSTRACT: Subclass overloading L<DateTime::Calendar::FrenchRevolutionary> to allow language extension

use Moose;
use MooseX::NonMoose;
extends 'DateTime::Calendar::FrenchRevolutionary';

use Class::Load ':all';
use namespace::autoclean;

=method set

Overloads L<DateTime::Calendar::FrenchRevolutionary> to allow setting locale, extending 'fr' and 'en'.

=cut

sub set {
  my $self = shift;
  my %args = @_;

  my $locale_arg = delete $args{locale};
  my $locale_class;

  if ($locale_arg) {
    die "only 'fr', 'en', 'it' and 'es' possible"
      unless $locale_arg =~ /^(?:en|fr|it|es)$/;

    $locale_class = 'App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::' . $locale_arg;
  }

  $self = $self->SUPER::set(%args);

  if ($locale_class) {
    try_load_class($locale_class)
      or die "Cannot import locale class $locale_class\n";
    load_class($locale_class);
    $self->{locale} = $locale_class->new();
  }

  return $self;
}

=head1 SEE ALSO

=over

=item L<spread-revolutionary-date>

=item L<App::SpreadRevolutionaryDate>

=item L<App::SpreadRevolutionaryDate::Config>

=item L<App::SpreadRevolutionaryDate::BlueskyLite>

=item L<App::SpreadRevolutionaryDate::Target>

=item L<App::SpreadRevolutionaryDate::Target::Bluesky>

=item L<App::SpreadRevolutionaryDate::Target::Twitter>

=item L<App::SpreadRevolutionaryDate::Target::Mastodon>

=item L<App::SpreadRevolutionaryDate::Target::Freenode>

=item L<App::SpreadRevolutionaryDate::Target::Freenode::Bot>

=item L<App::SpreadRevolutionaryDate::Target::Liberachat>

=item L<App::SpreadRevolutionaryDate::Target::Liberachat::Bot>

=item L<App::SpreadRevolutionaryDate::MsgMaker>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::fr>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::en>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::it>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::es>

=item L<App::SpreadRevolutionaryDate::MsgMaker::PromptUser>

=item L<App::SpreadRevolutionaryDate::MsgMaker::Telechat>

=item L<App::SpreadRevolutionaryDate::MsgMaker::Gemini>

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
