#
# This file is part of App-SpreadRevolutionaryDate
#
# This software is Copyright (c) 2019-2024 by Gérald Sédrati.
#
# This is free software, licensed under:
#
#   The GNU General Public License, Version 3, June 2007
#
use 5.014;
use utf8;
package App::SpreadRevolutionaryDate::BlueskyLite;
$App::SpreadRevolutionaryDate::BlueskyLite::VERSION = '0.34';
# ABSTRACT: .

use LWP::UserAgent;
use DateTime;
use JSON qw(encode_json decode_json);
use URI;
use Encode qw(decode_utf8);

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

  my %payload = (
    identifier => $args{'identifier'},
    password   => $args{'password'},
  );
  my $json = encode_json(\%payload);

  my $req = HTTP::Request->new('POST', 'https://bsky.social/xrpc/com.atproto.server.createSession');
  $req->header('Content-Type' => 'application/json');
  $req->content($json);
  my $response = $self{ua}->request($req);

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

  my ($facets, $embed) = $self->_generate_facets($text);
  my $json = encode_json({
    repo => $self->{did},
    collection => 'app.bsky.feed.post',
    record => {
      text => $text,
      facets => $facets,
      ($embed ?
        (embed => $embed)
        : ()
      ),
      createdAt => DateTime->now->iso8601 . 'Z',
    },
  });
  my $req = HTTP::Request->new('POST', 'https://bsky.social/xrpc/com.atproto.repo.createRecord');
  $req->header('Content-Type' => 'application/json');
  $req->content($json);
  my $response = $self->{ua}->request($req);
  return $response
}

sub _generate_facets {
  my $self = shift;
  my $text = shift || return [];
  my $facets = [];
  my $embed;
  my $pos = 0;
  foreach my $w (split /\s+/, $text) {
    my ($type, $attrib, $val);
    $w =~ s/[.,:;'"!\?()]+$//;
    $w =~ s/^[.,:;'"!\?()]+//g;
    if ($w =~ /^https?\:\/\//) {
      $type = 'app.bsky.richtext.facet#link';
      $attrib = 'uri';
      $val = $w;

      utf8::encode(my $text_bytes = $text);
      $pos = index($text_bytes, $w, $pos);
      my $end = $pos + length($w);

      push @$facets, {
        features => [
          {
            '$type' => $type,
            uri     => $val,
          },
        ],
        index => {
          byteStart => $pos,
          byteEnd   => $end,
        },
      };

      unless ($embed) {
        my $card = $self->_fetch_embed_url_card($val);
        if ($card) {
          $embed = {
                '$type'    => 'app.bsky.embed.external',
                'external' => $card,
          };
        }
      }

      $pos = $end;
    }
  }
  return ($facets, $embed);
}

sub _fetch_embed_url_card {
  my $self = shift;
  my $url = shift || return;

  my $card = {uri => $url};

  my $ua = LWP::UserAgent->new(env_proxy => 1, timeout => 10, agent =>'App::SpreadRevolutionaryDate bot');
  my $response = $ua->get($url);
  return unless $response->is_success;
  my $content = $response->content;
  return unless $content;

  if ($content =~ /<meta property="og:title" content="([^"]+)"/) {
    my $title = $1;
    ($card->{title}) = decode_utf8($title);
  } else {
    $card->{title} = '';
  }
  if ($content =~ /<meta property="og:description" content="([^"]+)"/) {
    my $description = $1;
    ($card->{description}) = decode_utf8($description);
  } else {
    $card->{description} = '';
  }
  if ($content =~ /<meta property="og:image" content="([^"]+)"/) {
    my $img_url = $1;
    unless ($img_url =~ m!://!) {
      $url = "$url/" unless $url =~ m!/$!;
      $img_url = $url . $img_url;
    }
    my $img_response = $ua->get($img_url);
    return unless $img_response->is_success;

    my $blob_req = HTTP::Request->new('POST', 'https://bsky.social/xrpc/com.atproto.repo.uploadBlob');
    $blob_req->header('Content-Type' => $img_response->header('Content-Type'));
    $blob_req->content($img_response->content);
    my $blob_response = $self->{ua}->request($blob_req);
    return unless $blob_response->is_success;

    my $blob_content = decode_json($blob_response->decoded_content);
    ($card->{thumb}) = $blob_content->{blob};
  }

  return $card;
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
