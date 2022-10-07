package AOCTest::BingoBoardFactory;

use strict;
use warnings;

use Bingo::Board;

my $numbers = [
    [ 22, 13, 17, 11, 0 ],
    [ 8,  2,  23, 4,  24 ],
    [ 21, 9,  14, 16, 7 ],
    [ 6,  10, 3,  18, 5 ],
    [ 1,  12, 20, 15, 19 ],
];

sub unmarked_board {
    my $board = Bingo::Board->new( grid => $numbers );

    return $board;
}

sub winning_board_row {
    my $board = Bingo::Board->new( grid => $numbers );

    my $grid = $board->grid;

    $grid->[2]->[0]->marked(1);
    $grid->[2]->[1]->marked(1);
    $grid->[2]->[2]->marked(1);
    $grid->[2]->[3]->marked(1);
    $grid->[2]->[4]->marked(1);

    return $board;
}

sub winning_board_column {
    my $board = Bingo::Board->new( grid => $numbers );

    my $grid = $board->grid;

    $grid->[0]->[1]->marked(1);
    $grid->[1]->[1]->marked(1);
    $grid->[2]->[1]->marked(1);
    $grid->[3]->[1]->marked(1);
    $grid->[4]->[1]->marked(1);

    return $board;
}

1;
