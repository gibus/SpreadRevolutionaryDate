#!perl

use Test::More tests => 6;

use App::SpreadRevolutionaryDate;

my $spread_revolutionary_date = App::SpreadRevolutionaryDate->new;

isa_ok($spread_revolutionary_date->{twitter}, 'App::SpreadRevolutionaryDate::Twitter', 'Twitter class constructor');
isa_ok($spread_revolutionary_date->{twitter}->{obj}, 'Net::Twitter::Lite::WithAPIv1_1', 'Twitter object');
isa_ok($spread_revolutionary_date->{mastodon}, 'App::SpreadRevolutionaryDate::Mastodon', 'Mastodon class constructor');
isa_ok($spread_revolutionary_date->{mastodon}->{obj}, 'Mastodon::Client', 'Mastodon object');
isa_ok($spread_revolutionary_date->{freenode}, 'App::SpreadRevolutionaryDate::Freenode', 'Freenode class constructor');
isa_ok($spread_revolutionary_date->{freenode}->{obj}, 'Bot::BasicBot', 'Freenode object');
