#!perl

use Test::More tests => 4;
use Test::Output;
use Test::NoWarnings;

use App::SpreadRevolutionaryDate;

@ARGV = ("--locale='fr'");
my $data_start = tell DATA;
my $fr_spread_revolutionary_date = App::SpreadRevolutionaryDate->new(\*DATA);
stdout_like { $fr_spread_revolutionary_date->spread() } qr/Spread to Twitter: Nous sommes le/, 'Spread to Twitter:';

@ARGV = ("--locale='en'");
seek DATA, $data_start, 0;
my $en_spread_revolutionary_date = App::SpreadRevolutionaryDate->new(\*DATA);
stdout_like { $en_spread_revolutionary_date->spread() } qr/Spread to Twitter:/, 'Spread to Twitter: We are';

@ARGV = ("--locale='klingon'");
seek DATA, $data_start, 0;
my $klingon_spread_revolutionary_date = App::SpreadRevolutionaryDate->new(\*DATA);
stdout_like { $klingon_spread_revolutionary_date->spread() } qr/Spread to Twitter:/, 'Spread to Twitter: Nous sommes le';

__DATA__

test
twitter

[twitter]
# Get these values from https://apps.twitter.com/
consumer_key        = 'ConsumerKey'
consumer_secret     = 'ConsumerSecret'
access_token        = 'AccessToken'
access_token_secret = 'AccessTokenSecret'
