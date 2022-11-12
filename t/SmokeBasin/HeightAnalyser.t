#!/usr/bin/perl

use Test2::V0;

use FindBin;

use lib "$FindBin::Bin/../../../lib";

use SmokeBasin::HeightAnalyser;

subtest 'low_point' => sub {
    my $height_map = [ [ 9, 9, 9 ], [ 9, 1, 9 ], [ 9, 9, 9 ] ];
    my $x          = 1;
    my $y          = 1;

    subtest
      'should return 1 if the point is lower than all surrounding points' =>
      sub {
        my $actual =
          SmokeBasin::HeightAnalyser::low_point( $height_map, $x, $y );

        my $expected = 1;

        is( $actual, $expected );
      };

    subtest
      'should return 0 if the point is not lower than all surrounding points'
      => sub {
        my $height_map = [ [ 1, 1, 1 ], [ 1, 9, 1 ], [ 1, 1, 1 ] ];
        my $x          = 1;
        my $y          = 1;

        my $actual =
          SmokeBasin::HeightAnalyser::low_point( $height_map, $x, $y );

        my $expected = 0;

        is( $actual, $expected );
      };

    subtest 'should handle corner case, no point above or left' => sub {
        my $x = 0;
        my $y = 0;

        my $actual =
          SmokeBasin::HeightAnalyser::low_point( $height_map, $x, $y );

        my $expected = 0;

        is( $actual, $expected );
    };

    subtest 'should handle corner case, no point below or right' => sub {
        my $height_map = [ [ 9, 9, 9 ], [ 9, 9, 9 ], [ 9, 9, 1 ] ];
        my $x          = 2;
        my $y          = 2;

        my $actual =
          SmokeBasin::HeightAnalyser::low_point( $height_map, $x, $y );

        my $expected = 1;

        is( $actual, $expected );
    };
};

done_testing();
