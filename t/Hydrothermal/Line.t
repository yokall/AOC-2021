#!/usr/bin/perl

use Test2::V0;

use lib 'lib';

use Hydrothermal::Line;

subtest 'new' => sub {
    subtest 'should initialise the line with points on the line' => sub {
        subtest 'for a horizontal line' => sub {
            my $start_point = { x => 0, y => 9 };
            my $end_point   = { x => 5, y => 9 };

            my $line = Hydrothermal::Line->new(
                start_point => $start_point,
                end_point   => $end_point
            );

            my $expected_points = [
                { x => 0, y => 9 },
                { x => 1, y => 9 },
                { x => 2, y => 9 },
                { x => 3, y => 9 },
                { x => 4, y => 9 },
                { x => 5, y => 9 },
            ];

            is( $line->points, $expected_points,
                'Line has the expected points' );
        };

        subtest 'for a "reverse" horizontal line' => sub {
            my $start_point = { x => 5, y => 9 };
            my $end_point   = { x => 0, y => 9 };

            my $line = Hydrothermal::Line->new(
                start_point => $start_point,
                end_point   => $end_point
            );

            my $expected_points = [
                { x => 5, y => 9 },
                { x => 4, y => 9 },
                { x => 3, y => 9 },
                { x => 2, y => 9 },
                { x => 1, y => 9 },
                { x => 0, y => 9 },
            ];

            is( $line->points, $expected_points,
                'Line has the expected points' );
        };

        subtest 'for a vertical line' => sub {
            my $start_point = { x => 9, y => 0 };
            my $end_point   = { x => 9, y => 5 };

            my $line = Hydrothermal::Line->new(
                start_point => $start_point,
                end_point   => $end_point
            );

            my $expected_points = [
                { x => 9, y => 0 },
                { x => 9, y => 1 },
                { x => 9, y => 2 },
                { x => 9, y => 3 },
                { x => 9, y => 4 },
                { x => 9, y => 5 },
            ];

            is( $line->points, $expected_points,
                'Line has the expected points' );
        };

        subtest 'for a "reverse" vertical line' => sub {
            my $start_point = { x => 9, y => 5 };
            my $end_point   = { x => 9, y => 0 };

            my $line = Hydrothermal::Line->new(
                start_point => $start_point,
                end_point   => $end_point
            );

            my $expected_points = [
                { x => 9, y => 5 },
                { x => 9, y => 4 },
                { x => 9, y => 3 },
                { x => 9, y => 2 },
                { x => 9, y => 1 },
                { x => 9, y => 0 },
            ];

            is( $line->points, $expected_points,
                'Line has the expected points' );
        };
    };
};

subtest 'is_diagonal' => sub {
    subtest 'should return true if the line is a diagonal' => sub {
        my $start_point = { x => 6, y => 4 };
        my $end_point   = { x => 2, y => 0 };

        my $line = Hydrothermal::Line->new(
            start_point => $start_point,
            end_point   => $end_point
        );

        is( $line->is_diagonal, T );
    };

    subtest 'should return false if the line is not a diagonal' => sub {
        my $start_point = { x => 9, y => 5 };
        my $end_point   = { x => 9, y => 0 };

        my $line = Hydrothermal::Line->new(
            start_point => $start_point,
            end_point   => $end_point
        );

        is( $line->is_diagonal, F );
    };
};

done_testing();
