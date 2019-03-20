#!perl

use Test::More tests => 4;
use Test::NoWarnings;

package App::SpreadRevolutionaryDate::Target::Ezln;

use Moose;
use namespace::autoclean;

has 'subcomandantes' => (is => 'ro', isa => 'ArrayRef[Str]', required => 1);
has 'land' => (is => 'ro', isa => 'Str', required => 1);

package main;

use App::SpreadRevolutionaryDate;

my $spread_revolutionary_date = App::SpreadRevolutionaryDate->new(\*DATA);

is_deeply($spread_revolutionary_date->config->targets, ['ezln'], 'EZLN target option set');
is($spread_revolutionary_date->config->ezln_land, 'Chiapas', 'EZLN land value');
is_deeply($spread_revolutionary_date->config->ezln_subcomandantes, ['Marcos', 'Moisés', 'Galeano'], 'EZLN subcomandantes values');

__DATA__
targets = 'ezln'

[ezln]
subcomandantes = 'Marcos'
subcomandantes = 'Moisés'
subcomandantes = 'Galeano'
land = 'Chiapas'
