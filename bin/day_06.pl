#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;

use lib "$FindBin::Bin/../lib";

use LaternFish::Simulator;

my $starting_fish = [
    2, 1, 2, 1, 5, 1, 5, 1, 2, 2, 1, 1, 5, 1, 4, 4, 4, 3, 1, 2, 2, 3, 4, 1,
    1, 5, 1, 1, 4, 2, 5, 5, 5, 1, 1, 4, 5, 4, 1, 1, 4, 2, 1, 4, 1, 2, 2, 5,
    1, 1, 5, 1, 1, 3, 4, 4, 1, 2, 3, 1, 5, 5, 4, 1, 4, 1, 2, 1, 5, 1, 1, 1,
    3, 4, 1, 1, 5, 1, 5, 1, 1, 5, 1, 1, 4, 3, 2, 4, 1, 4, 1, 5, 3, 3, 1, 5,
    1, 3, 1, 1, 4, 1, 4, 5, 2, 3, 1, 1, 1, 1, 3, 1, 2, 1, 5, 1, 1, 5, 1, 1,
    1, 1, 4, 1, 4, 3, 1, 5, 1, 1, 5, 4, 4, 2, 1, 4, 5, 1, 1, 3, 3, 1, 1, 4,
    2, 5, 5, 2, 4, 1, 4, 5, 4, 5, 3, 1, 4, 1, 5, 2, 4, 5, 3, 1, 3, 2, 4, 5,
    4, 4, 1, 5, 1, 5, 1, 2, 2, 1, 4, 1, 1, 4, 2, 2, 2, 4, 1, 1, 5, 3, 1, 1,
    5, 4, 4, 1, 5, 1, 3, 1, 3, 2, 2, 1, 1, 4, 1, 4, 1, 2, 2, 1, 1, 3, 5, 1,
    2, 1, 3, 1, 4, 5, 1, 3, 4, 1, 1, 1, 1, 4, 3, 3, 4, 5, 1, 1, 1, 1, 1, 2,
    4, 5, 3, 4, 2, 1, 1, 1, 3, 3, 1, 4, 1, 1, 4, 2, 1, 5, 1, 1, 2, 3, 4, 2,
    5, 1, 1, 1, 5, 1, 1, 4, 1, 2, 4, 1, 1, 2, 4, 3, 4, 2, 3, 1, 1, 2, 1, 5,
    4, 2, 3, 5, 1, 2, 3, 1, 2, 2, 1, 4
];

my $simulator = LaternFish::Simulator->new();

$simulator->load_starting_school($starting_fish);

my $number_of_days = 80;
$simulator->simulate_days($number_of_days);

warn 'Part 1 result: ' . $simulator->fish_count();

$simulator->load_starting_school($starting_fish);

$number_of_days = 256;
$simulator->simulate_days($number_of_days);

warn 'Part 2 result: ' . $simulator->fish_count();
