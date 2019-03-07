use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
package App::SpreadRevolutionaryDate::Mastodon;

# ABSTRACT: Subclass of L<App::SpreadRevolutionaryDate> to handle spreading on Mastodon.

use Mastodon::Client;

=method new

Constructor class method. Takes one mandatory argument: C<$config> which should be an C<App::SpreadRevolutionaryDate::Config> object. Authentifies to Mastodon and returns an C<App::SpreadRevolutionaryDate::Mastodon> object.

=cut

sub new {
  my $class = shift;
  my $config = shift;
  my $mastodon = Mastodon::Client->new(
                  instance        => $config->mastodon_instance,
                  client_id       => $config->mastodon_client_id,
                  client_secret   => $config->mastodon_client_secret,
                  access_token    => $config->mastodon_access_token,
                  #coerce_entities => 1,
                  name            => 'RevolutionaryDate');
  bless {config => $config, obj => $mastodon}, $class;
}

=method spread

Spreads a message to Mastodon. Takes one mandatory argument: C<$msg> which should be the message to spread as a characters string. If C<test> option is set the message is printed on standard output and not spread on Mastodon.

=cut

sub spread {
  my $self = shift;
  my $msg = shift;
  if ($self->{config}->test) {
    print "Spread to Mastodon $msg\n";
  } else {
    $self->{obj}->post_status($msg);
  }
}

=head1 SEE ALSO

=over

=item L<spread-revolutionary-date|https://metacpan.org/pod/distribution/App-SpreadRevolutionaryDate/bin/spread-revolutionary-date>

=item L<App::SpreadRevolutionaryDate>

=item L<App::SpreadRevolutionaryDate::Config>

=item L<App::SpreadRevolutionaryDate::Twitter>

=item L<App::SpreadRevolutionaryDate::Freenode>

=item L<App::SpreadRevolutionaryDate::Freenode::Bot>

=back

=cut

1;
