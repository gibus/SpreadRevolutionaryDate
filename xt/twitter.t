#!perl

use Test::More;
use Test::Output;

unless(   -f $ENV{HOME} . '/.config/spread-revolutionary-date/spread-revolutionary-date.conf'
       || -f $ENV{HOME} . '/.spread-revolutionary-date.conf') {
  plan skip_all => 'No user config file found';
} else {
  plan tests => 1;
}

use App::SpreadRevolutionaryDate;

@ARGV = ('--test', '--twitter');
my $spread_revolutionary_date = App::SpreadRevolutionaryDate->new;

stdout_like { $spread_revolutionary_date->spread } qr/Spread to Twitter:/, 'Spread to Twitter';
