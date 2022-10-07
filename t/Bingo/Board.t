#!/usr/bin/perl

use Test2::V0;

use lib 'lib';

use Bingo::Board;

use lib 't/lib';

use AOCTest::BingoBoardFactory;

subtest 'new' => sub {
    subtest 'should initilise the board with squares' => sub {
        my $numbers = [
            [ 22, 13, 17, 11, 0 ],
            [ 8,  2,  23, 4,  24 ],
            [ 21, 9,  14, 16, 7 ],
            [ 6,  10, 3,  18, 5 ],
            [ 1,  12, 20, 15, 19 ],
        ];

        my $board = Bingo::Board->new( grid => $numbers );

        my $grid = $board->grid;

        is( scalar(@$grid), 5, 'There are 5 rows' );

        foreach my $row (@$grid) {
            is( scalar(@$row), 5, 'There are 5 squares in this row' );
            foreach my $square (@$row) {
                isa_ok( $square, ["Bingo::Square"],
                    'square should be a Bingo::Square' );
            }
        }
    };
};

subtest 'mark_number' => sub {
    subtest
        'should find the square with the given number and set marked to true'
        => sub {
        my $board = AOCTest::BingoBoardFactory::unmarked_board();

        $board->mark_number(5);

        is( $board->grid->[3]->[4]->is_marked, 1 );
        };
};

subtest 'has_won' => sub {
    subtest 'should return false if the board is not "bingo"' => sub {
        my $board = AOCTest::BingoBoardFactory::unmarked_board();

        is( $board->has_won(), 0 );
    };

    subtest 'should return true if all squares are marked' => sub {
        subtest 'in a row' => sub {
            my $board = AOCTest::BingoBoardFactory::winning_board_row();

            is( $board->has_won(), 1 );
        };
        subtest 'in a column' => sub {
            my $board = AOCTest::BingoBoardFactory::winning_board_column();

            is( $board->has_won(), 1 );
        };
    };
};

subtest 'sum_unmarked_squares' => sub {
    subtest 'should return the sum of all unmarked squares' => sub {
        my $board = AOCTest::BingoBoardFactory::unmarked_board();

        my $actual   = $board->sum_unmarked_squares();
        my $expected = 300;

        is( $actual, $expected );
    };
};

done_testing();
