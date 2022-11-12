#!/usr/bin/env perl

use strict;
use warnings;

use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use SmokeBasin::HeightAnalyser;

my $height_map = Common::FileReader::read_file_to_2d_array(
    dirname(__FILE__) . '/../files/09_puzzle_input.txt' );

my $low_point_sum;
for ( my $y = 0 ; $y < scalar( @{$height_map} ) ; $y++ ) {
    for ( my $x = 0 ; $x < scalar( @{ $height_map->[$y] } ) ; $x++ ) {
        if ( SmokeBasin::HeightAnalyser::low_point( $height_map, $x, $y ) ) {
            $low_point_sum += $height_map->[$y]->[$x] + 1;
        }
    }
}

warn "Part 1 answer: $low_point_sum";
