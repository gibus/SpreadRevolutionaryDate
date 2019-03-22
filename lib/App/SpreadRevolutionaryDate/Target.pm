use 5.014;
use utf8;
package App::SpreadRevolutionaryDate::Target;

# ABSTRACT: Role providing interface for targets of L<App::SpreadRevolutionaryDate>.

use MooseX::Role::Parameterized;
use namespace::autoclean;

parameter class_name => (
    isa     => 'Str',
    default => 'Any',
);

role {
    my $p = shift;

    has obj => (
        is => 'ro',
        isa => $p->class_name,
        required => 1,
    );

    requires 'spread';
};

=head1 SEE ALSO

=over

=item L<spread-revolutionary-date|https://metacpan.org/pod/distribution/App-SpreadRevolutionaryDate/bin/spread-revolutionary-date>

=item L<App::SpreadRevolutionaryDate>

=item L<App::SpreadRevolutionaryDate::Config>

=item L<App::SpreadRevolutionaryDate::Target::Twitter>

=item L<App::SpreadRevolutionaryDate::Target::Mastodon>

=item L<App::SpreadRevolutionaryDate::Target::Freenode>

=item L<App::SpreadRevolutionaryDate::Target::Freenode::Bot>

=back

=cut

# A module must return a true value. Traditionally, a module returns 1.
# But this module is a revolutionary one, so it discards all old traditions.
# Idea borrowed from Jean Forget's DateTime::Calendar::FrenchRevolutionary.
"Quand le gouvernement viole les droits du peuple,
l'insurrection est pour le peuple le plus sacré
et le plus indispensable des devoirs";
