package Bingo::Board;

use Data::Dumper;
use List::Util qw/sum/;

use Moose;
use Moose::Util::TypeConstraints;

use Bingo::Square;

# Our new subtype
subtype 'GridOfSquares', as 'ArrayRef[ArrayRef[Bingo::Square]]';

# Define the coercion from a string to
# and array of strings
coerce 'GridOfSquares', from 'ArrayRef[ArrayRef[Int]]', via {
    my $grid_of_numbers = $_;

    my @grid_of_squares;
    foreach my $row (@$grid_of_numbers) {
        my @row_of_squares;
        foreach my $number (@$row) {
            my $square = Bingo::Square->new( number => $number );
            push( @row_of_squares, $square );
        }

        push( @grid_of_squares, \@row_of_squares );
    }

    return \@grid_of_squares;
};

has 'grid' => (
    is     => 'ro',
    isa    => 'GridOfSquares',
    coerce => 1,
);

sub mark_number {
    my ( $self, $number ) = @_;

    foreach my $row ( @{ $self->grid } ) {
        foreach my $square (@$row) {
            if ( $square->number == $number ) {
                $square->marked(1);
                return;
            }
        }
    }
}

sub has_won {
    my ($self) = @_;

    return 1
        if ( _any_row_is_fully_marked( $self->grid )
        || _any_column_is_fully_marked( $self->grid ) );

    return 0;
}

sub _any_row_is_fully_marked {
    my $grid = shift;

    foreach my $row (@$grid) {
        my @row_marks = map { $_->is_marked } @{$row};
        if ( sum(@row_marks) == 5 ) {
            return 1;
        }
    }

    return 0;
}

sub _any_column_is_fully_marked {
    my $grid = shift;

    my $number_of_columns = scalar( @{ @$grid[0] } );

    for ( my $i = 0; $i < $number_of_columns; $i++ ) {
        my @column_marks = map { $_->[$i]->is_marked } @$grid;
        if ( sum(@column_marks) == 5 ) {
            return 1;
        }
    }

    return 0;
}

sub sum_unmarked_squares {
    my ($self) = @_;

    # I find the nested foreach loops more readable, no difference in speed

    # my $sum = sum(    # sum all the unmarked square numbers
    #     map      { $_->number }            # extract the square numbers
    #         grep { !$_->is_marked }        # filter to unmarked squares only
    #         map  {@$_} @{ $self->grid }    # flatten 2d array
    # );

    my $sum = 0;
    foreach my $row ( @{ $self->grid } ) {
        foreach my $square (@$row) {
            unless ( $square->is_marked ) {
                $sum += $square->number;
            }
        }
    }

    return $sum;
}

1;
