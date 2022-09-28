#!/usr/bin/env perl

use strict;
use warnings;

use lib '../lib';
use lib 'lib';

use Common::FileReader;
use DayThree::DiagnosticOperations;

my $diagnostic_output = Common::FileReader::read_file_to_array('/home/colin/AOC-2021/day-03/files/puzzle_input.txt');

my $part_one_result = DayThree::DiagnosticOperations::calculate_power_consumption($diagnostic_output);

warn "Part one result: $part_one_result";

my $part_two_result = DayThree::DiagnosticOperations::calculate_life_support_rating($diagnostic_output);

warn "Part two result: $part_two_result";

