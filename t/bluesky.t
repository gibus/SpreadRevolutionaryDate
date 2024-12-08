#!/usr/bin/perl
use utf8;

BEGIN {
    $ENV{OUTPUT_CHARSET} = 'UTF-8';
}
use open qw(:std :encoding(UTF-8));
binmode(DATA, ":encoding(UTF-8)");

use Test::More tests => 2;
use Test::NoWarnings;
use Test::Output;
use File::HomeDir;

use App::SpreadRevolutionaryDate;

@ARGV = ('--test', '--bluesky');
my $spread_revolutionary_date = App::SpreadRevolutionaryDate->new(\*DATA);

stdout_like { $spread_revolutionary_date->spread } qr/Diffusé sur Bluesky : Nous sommes le/, 'Spread on Bluesky';

__DATA__

[bluesky]
# Get these values from https://bsky.app/
identifier = 'Identifier'
password   = 'Password'
