#!/usr/bin/perl

use Test2::V0;

use lib 'lib';

use Hydrothermal::PointCounter;

use lib 't/lib';

use AOCTest::LineFactory;

subtest 'tally_points' => sub {
    my $lines = AOCTest::LineFactory::lines();

    my $actual = Hydrothermal::PointCounter::tally_points($lines);

    my $expected = {
        '0,9' => 2,
        '1,9' => 2,
        '2,9' => 2,
        '3,9' => 1,
        '4,9' => 1,
        '5,9' => 1,
    };

    is( $actual, $expected, 'Point counts are as expected' );
};

subtest 'count_overlaping_points' => sub {
    my $point_counts = {
        '0,9' => 2,
        '1,9' => 2,
        '2,9' => 2,
        '3,9' => 1,
        '4,9' => 1,
        '5,9' => 1,
    };

    my $actual
        = Hydrothermal::PointCounter::count_overlaping_points($point_counts);

    is( $actual, '3', 'Count number of points that overlap' );
};

done_testing();
