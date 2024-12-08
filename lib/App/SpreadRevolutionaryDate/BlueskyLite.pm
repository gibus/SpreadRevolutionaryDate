use 5.014;
use utf8;
package App::SpreadRevolutionaryDate::BlueskyLite;

# ABSTRACT: .

use LWP::UserAgent;
use DateTime;
use JSON qw(encode_json decode_json);
use URI;

use namespace::autoclean;

BEGIN {
  unless ($ENV{PERL_UNICODE} && $ENV{PERL_UNICODE} =~ /A/) {
    use Encode qw(decode_utf8);
    @ARGV = map { decode_utf8($_, 1) } @ARGV;
  }
}

=head1 Methods

=head2 new

Constructor class method. Takes identifier and passwords mandatory arguments. Returns an C<App::SpreadRevolutionaryDate::BlueskyLite> object.

=cut

sub new {
  my ($class, %args) = @_;

  my %self;
  $self{ua} = LWP::UserAgent->new(env_proxy => 1, timeout => 10, agent =>'App::SpreadRevolutionaryDate bot');
  $self{ua}->default_header('Accept' => 'application/json');
  $self{ua}->default_header('Content-Type' => 'application/json');

  my %payload = (
    identifier => $args{'identifier'},
    password   => $args{'password'},
  );
  my $json = encode_json(\%payload);

  my $response = $self{ua}->post(
    'https://bsky.social/xrpc/com.atproto.server.createSession',
    Content_Type => 'application/json',
    Content => $json
  );

  if ($response->is_success) {
    my $content = decode_json($response->decoded_content);
    my $did = $content->{did};
    my $access_jwt = $content->{accessJwt};
    $self{ua}->default_header('Authorization' => 'Bearer ' . $access_jwt);
    $self{did} = $did;
  }

  my $self = bless(\%self, $class);
  return $self;
}

=head2 create_post

Creates a Bluesky post.

=cut

sub create_post {
  my ($self, $text) = @_;

  # parse text for URIs and mentions
  my $facets = $self->_generate_facets($text);
  # build JSON and post to com.atproto.repo.createRecord endpoint
  my $json = encode_json({
    repo => $self->{did},
    collection => 'app.bsky.feed.post',
    record => {
      text => $text,
      facets => $facets,
      createdAt => DateTime->now->iso8601 . 'Z',
    },
  });
  my $response = $self->{ua}->post(
    "https://bsky.social/xrpc/com.atproto.repo.createRecord",
    Content_Type => 'application/json',
    Content => $json,
  );
  $response
}

sub _generate_facets {
  my $self = shift;
  my $text = shift || return [];
  my $output = [];
  my $pos = 0;
  foreach my $w (split /\s+/, $text) {
    my ($type, $attrib, $val);
    $w =~ s/[\.,:;'"!\?]+$//;
    if ($w =~ /^https?\:\/\//) {
      $type = 'app.bsky.richtext.facet#link';
      $attrib = 'uri';
      $val = $w;

      $pos = index($text, $w, $pos) + 1;
      my $end = $pos + length($w);
      push @$output, {
        features => [{
          '$type' => $type,
          uri     => $val,
        }],
        index => {
          byteStart => $pos,
          byteEnd   => $end,
        },
      };
      $pos = $end;
    }
  }
  $output
}

=head1 SEE ALSO

=over

=item L<spread-revolutionary-date>

=item L<App::SpreadRevolutionaryDate>

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

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Calendar>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::fr>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::en>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::it>

=item L<App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::es>

=item L<App::SpreadRevolutionaryDate::MsgMaker::PromptUser>

=back

=cut

# A module must return a true value. Traditionally, a module returns 1.
# But this module is a revolutionary one, so it discards all old traditions.
# Idea borrowed from Jean Forget's DateTime::Calendar::FrenchRevolutionary.
"Quand le gouvernement viole les droits du peuple,
l'insurrection est pour le peuple le plus sacré
et le plus indispensable des devoirs";
