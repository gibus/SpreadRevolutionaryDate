#!perl

use Test::More tests => 11;
use Test::NoWarnings;

use App::SpreadRevolutionaryDate;

my $spread_revolutionary_date = App::SpreadRevolutionaryDate->new(\*DATA);

isa_ok($spread_revolutionary_date, 'App::SpreadRevolutionaryDate', 'Base class constructor');
isa_ok($spread_revolutionary_date->{config}, 'App::SpreadRevolutionaryDate::Config', 'Config class constructor');

is($spread_revolutionary_date->{config}->twitter, 1, 'Twitter option set by default');
is($spread_revolutionary_date->{config}->mastodon, 1, 'Mastodon option set by default');
is($spread_revolutionary_date->{config}->freenode, 1, 'Freenode option set by default');

is($spread_revolutionary_date->{config}->test, 1, 'Test option set');

is($spread_revolutionary_date->{config}->twitter_consumer_key, 'ConsumerKey', 'Twitter consumer_key value');
is($spread_revolutionary_date->{config}->twitter_consumer_secret, 'ConsumerSecret', 'Twitter consumer_secret value');
is($spread_revolutionary_date->{config}->twitter_access_token, 'AccessToken', 'Twitter access_token value');
is($spread_revolutionary_date->{config}->twitter_access_token_secret, 'AccessTokenSecret', 'Twitter access_token_secret value');

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
