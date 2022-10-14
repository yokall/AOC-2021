#!/usr/bin/env perl

use strict;
use warnings;

use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use Hydrothermal::LineDefinitionParser;
use Hydrothermal::PointCounter;

my $puzzle_input = Common::FileReader::read_file_to_array(
    dirname(__FILE__) . '/../files/05_puzzle_input.txt' );

my $lines = Hydrothermal::LineDefinitionParser::parse_input($puzzle_input);

my $include_diagonals = 0;
my $point_counts
    = Hydrothermal::PointCounter::tally_points( $lines, $include_diagonals );

warn 'Part 1: '
    . Hydrothermal::PointCounter::count_overlaping_points($point_counts);

$include_diagonals = 1;
$point_counts
    = Hydrothermal::PointCounter::tally_points( $lines, $include_diagonals );

warn 'Part 2: '
    . Hydrothermal::PointCounter::count_overlaping_points($point_counts);
