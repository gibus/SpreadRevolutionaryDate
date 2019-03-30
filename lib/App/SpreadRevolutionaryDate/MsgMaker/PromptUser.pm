use 5.014;
use utf8;
package App::SpreadRevolutionaryDate::MsgMaker::PromptUser;

# ABSTRACT: MsgMaker class for L<App::SpreadRevolutionaryDate> to build message by prompting user

use Moose;
with 'App::SpreadRevolutionaryDate::MsgMaker';

use open qw(:std :utf8);
use IO::Prompt::Hooked;

use Locale::TextDomain 'App-SpreadRevolutionaryDate';
use namespace::autoclean;

has 'default' => (
    is  => 'ro',
    isa => 'Str',
    required => 1,
    default => 'Goodbye old world, hello revolutionary worlds',
);

around BUILDARGS => sub {
  my ($orig, $class, %args) = @_;

  # Do not pass default => undef to force default in attribute definition
  delete $args{default}
    if exists $args{default} && !defined $args{default};
  return $class->$orig(%args);
};

=method compute

Prompts user for the message to be spread. Takes no argument. Returns message as string, ready to be spread.

=cut

sub compute {
  my $self = shift;

  my $question = __"Please, enter message to spread";
  my $confirm_ok = __"y";
  my $confirm_nok = __"n";
  my $confirm_abort = __"A";
  my $confirm_abort_text = __x("or {abort} to abort", abort => $confirm_abort);
  my $confirm_intro = __"Spread";
  my $confirm_question = __x("confirm ({confirm_ok}/{confirm_nok} {confirm_abort_text})?", confirm_ok => $confirm_ok, confirm_nok => $confirm_nok, confirm_abort_text => $confirm_abort_text);
  my $confirm_error = __x("Input must be \"{confirm_ok}\" or \"{confirm_nok}\"\n", confirm_ok => $confirm_ok, confirm_nok => $confirm_nok);
  my $abort = __"OK not spreading";

  my $confirm = $confirm_nok;
  my $msg;
  while (defined $confirm && $confirm !~ qr($confirm_ok)) {
    $msg = prompt($question, $self->default);
    $confirm = prompt(
      message  => $confirm_intro . ' "' . $msg . '", ' . $confirm_question,
      default  => $confirm_ok,
      validate => qr/^[$confirm_ok$confirm_nok]$/i,
      escape   => qr/^$confirm_abort$/,
      error    => $confirm_error,
      tries    => 2,
    );
  }
  die "$abort\n" unless defined $confirm && $confirm =~ qr($confirm_ok);
  return $msg;
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

=item L<App::SpreadRevolutionaryDate::Target::MsgMaker::RevolutionaryDate>

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
