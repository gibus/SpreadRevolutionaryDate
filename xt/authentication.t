#!/usr/bin/perl

use Test::More;
use File::HomeDir;

unless(   -f File::HomeDir->my_home . '/.config/spread-revolutionary-date/spread-revolutionary-date.conf'
       || -f File::HomeDir->my_home . '/.spread-revolutionary-date.conf') {
  plan skip_all => 'No user config file found';
} else {
  plan tests => 3;
}

use App::SpreadRevolutionaryDate;

@ARGV = ('--test', '--twitter_api=1', '--targets=mastodon', '--targets=bluesky', '--targets=twitter');
my $spread_revolutionary_date = App::SpreadRevolutionaryDate->new;

eval { $spread_revolutionary_date->targets->{mastodon}->obj->get_account };
ok(!$@, 'Mastodon connection with actual credentials in user conf');

ok($spread_revolutionary_date->targets->{bluesky}->obj->{did}, 'Bluesky connection with actual credentials in user conf');

eval { $spread_revolutionary_date->targets->{twitter}->obj->verify_credentials };
ok(!$@, 'Twitter connection with actual credentials in user conf');
