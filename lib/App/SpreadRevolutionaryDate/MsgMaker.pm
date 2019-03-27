use 5.014;
use utf8;
package App::SpreadRevolutionaryDate::MsgMaker;

# ABSTRACT: Role providing interface for crafting a message to be spread by L<App::SpreadRevolutionaryDate>.

use Moose::Role;
use namespace::autoclean;

has locale => (
  is => 'ro',
  isa => 'Str',
  required => 1,
  default => 'fr'
);

requires 'compute';

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
