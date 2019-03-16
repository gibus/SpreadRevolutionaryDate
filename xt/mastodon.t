#!perl

use Test::More;
use Test::Output;
use File::HomeDir;

unless(   -f File::HomeDir->my_home() . '/.config/spread-revolutionary-date/spread-revolutionary-date.conf'
       || -f File::HomeDir->my_home() . '/.spread-revolutionary-date.conf') {
  plan skip_all => 'No user config file found';
} else {
  plan tests => 1;
}

use App::SpreadRevolutionaryDate;

@ARGV = ('--test', '--mastodon');
my $spread_revolutionary_date = App::SpreadRevolutionaryDate->new();

stdout_like { $spread_revolutionary_date->spread } qr/Spread to Mastodon/, 'Spread to Mastodon';
