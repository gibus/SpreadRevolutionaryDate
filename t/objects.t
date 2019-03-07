#!perl

use Test::More tests => 8;
use Test::NoWarnings;

use App::SpreadRevolutionaryDate;

my $spread_revolutionary_date = App::SpreadRevolutionaryDate->new(\*DATA);

isa_ok($spread_revolutionary_date->{twitter}, 'App::SpreadRevolutionaryDate::Twitter', 'Twitter class constructor');
isa_ok($spread_revolutionary_date->{twitter}->{obj}, 'Net::Twitter::Lite::WithAPIv1_1', 'Twitter object');
isa_ok($spread_revolutionary_date->{mastodon}, 'App::SpreadRevolutionaryDate::Mastodon', 'Mastodon class constructor');
isa_ok($spread_revolutionary_date->{mastodon}->{obj}, 'Mastodon::Client', 'Mastodon object');
isa_ok($spread_revolutionary_date->{freenode}, 'App::SpreadRevolutionaryDate::Freenode', 'Freenode class constructor');

eval { $spread_revolutionary_date->{twitter}->{obj}->verify_credentials };
is($@, '401: Authorization Required', 'Twitter no connection with fake credentials');

eval { $spread_revolutionary_date->{mastodon}->{obj}->get_account };
like($@, qr/^Could not complete request: 500 Can't connect to Instance/, 'Mastodon no connection with fake credentials');

__DATA__

test

[twitter]
# Get these values from https://apps.twitter.com/
consumer_key        = 'ConsumerKey'
consumer_secret     = 'ConsumerSecret'
access_token        = 'AccessToken'
access_token_secret = 'AccessTokenSecret'

[mastodon]
# Get these values from https://<your mastodon instance>/settings/applications
instance        = 'Instance'
client_id       = 'ClientId'
client_secret   = 'ClientSecret'
access_token    = 'AccessToken'

[freenode]
# See https://freenode.net/kb/answer/registration to register
nickname      = 'NickName'
password      = 'Password'
test_channels = '#TestChannel1'
test_channels = '#TestChannel2'
channels      = '#Channel1'
channels      = '#Channel2'
channels      = '#Channel3'
