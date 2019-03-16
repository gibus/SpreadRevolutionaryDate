use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
package App::SpreadRevolutionaryDate::Mastodon;

# ABSTRACT: Subclass of L<App::SpreadRevolutionaryDate> to handle spreading on Mastodon.

use Moose;
use namespace::autoclean;
use Mastodon::Client;

has 'obj' => (
    is  => 'ro',
    isa => 'Mastodon::Client',
    required => 1,
);

has 'instance' => (
    is  => 'ro',
    isa => 'Str',
    required => 1,
);

has 'client_id' => (
    is  => 'ro',
    isa => 'Str',
    required => 1,
);

has 'client_secret' => (
    is  => 'ro',
    isa => 'Str',
    required => 1,
);

has 'access_token' => (
    is  => 'ro',
    isa => 'Str',
    required => 1,
);

=method new

Constructor class method. Takes a hash argument with the following mandatory keys: C<instance>, C<client_id>, C<client_secret>, and C<access_token>, with all values being strings. Authentifies to Mastodon and returns an C<App::SpreadRevolutionaryDate::Mastodon> object.

=cut

around BUILDARGS => sub {
  my $orig = shift;
  my $class = shift;
  my $args = $class->$orig(@_);

  $args->{obj} = Mastodon::Client->new(
                  instance        => $args->{instance},
                  client_id       => $args->{client_id},
                  client_secret   => $args->{client_secret},
                  access_token    => $args->{access_token},
                  name            => 'RevolutionaryDate');
  return $args;
};

=method spread

Spreads a message to Mastodon. Takes one mandatory argument: C<$msg> which should be the message to spread as a characters string; and one optional argument: C<test>, which defaults to C<false>, and if C<true> prints the message on standard output instead of spreading on Mastodon.

=cut

sub spread {
  my $self = shift;
  my $msg = shift;
  my $test = shift // 0;
  if ($test) {
    print "Spread to Mastodon $msg\n";
  } else {
    $self->obj->post_status($msg);
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

no Moose;
__PACKAGE__->meta->make_immutable;
