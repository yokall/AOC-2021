#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use Bingo::Square;

subtest 'new' => sub {
    subtest
        'should create a Square with the specified number and marked be defaulted to false'
        => sub {
        my $square = Bingo::Square->new( number => 24 );

        is( $square->number,    24, 'Number is set correctly' );
        is( $square->is_marked, 0,  'Marked is set correctly' );
        };
};

done_testing();
