#!perl

use Test::More;

unless(   -f $ENV{HOME} . '/.config/spread-revolutionary-date/spread-revolutionary-date.conf'
       || -f $ENV{HOME} . '/.spread-revolutionary-date.conf') {
  plan skip_all => 'No user config file found';
} else {
  plan tests => 2;
}

use App::SpreadRevolutionaryDate;

my $spread_revolutionary_date = App::SpreadRevolutionaryDate->new;

eval { $spread_revolutionary_date->{twitter}->{obj}->verify_credentials };
ok(!$@, 'Twitter connection with actual credentials in user conf');

eval { $spread_revolutionary_date->{mastodon}->{obj}->get_account };
ok(!$@, 'Mastodon connection with actual credentials in user conf');
