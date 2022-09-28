#!/usr/bin/perl

use strict;
use warnings;

use Test::Deep;
use Test::More;

use_ok('DayThree::BinaryOperations');

my $LIST_OF_BINARY_NUMBERS = [
	'00100',
	'11110',
	'10110',
	'10111',
	'10101',
	'01111',
	'00111',
	'11100',
	'10000',
	'11001',
	'00010',
	'01010',
];
my $LIST_OF_BINARY_NUMBERS_EQUAL_NUMBER_OF_BITS = [
	'00100',
	'11110',
	'11110',
	'10111',
	'10001',
	'01011',
	'00111',
	'11100',
	'10000',
	'01001',
	'00010',
	'01001',
];
my $BINARY_NUMBER = '10110';

subtest 'create_binary_number_from_least_common_bit' => sub {
	subtest 'should return a binary number made from the least common bit at each position in a list of binary numbers' => sub {
		my $actual = DayThree::BinaryOperations::create_binary_number_from_least_common_bit($LIST_OF_BINARY_NUMBERS);

		my $expected = '01001';

		is($actual, $expected, 'Binary number created from least common bits');
	};

	subtest 'should prefer 0 when number of 1s and 0s are the same' => sub {
		my $actual = DayThree::BinaryOperations::create_binary_number_from_least_common_bit($LIST_OF_BINARY_NUMBERS_EQUAL_NUMBER_OF_BITS);

		my $expected = '00000';

		is($actual, $expected, 'Binary number created from least common bits');
	};

	subtest 'should return a single bit if passed a position' => sub {
		my $actual = DayThree::BinaryOperations::create_binary_number_from_least_common_bit($LIST_OF_BINARY_NUMBERS, 2);

		my $expected = '0';

		is($actual, $expected, 'Binary number created from least common bits');
	};
};

subtest 'invert_binary_number' => sub {
	subtest 'should return an inverted binary number from a binary number' => sub {
		my $actual = DayThree::BinaryOperations::invert_binary_number($BINARY_NUMBER);

		my $expected = '01001';

		is($actual, $expected, 'Binary number inverted');
	};
};

subtest 'binary_to_decimal' => sub {
	subtest 'should return the decimal equivalent of a binary number' => sub {
		my $actual = DayThree::BinaryOperations::binary_to_decimal($BINARY_NUMBER);

		my $expected = 22;

		is($actual, $expected, 'Binary number inverted');
	};
};

subtest 'filter_by_bit' => sub {
	subtest 'should return a filtered list of binary numbers by the value of the bit at the specified position' => sub {
		my $position = 1;
		my $bit_Value = 0;
		my $actual = DayThree::BinaryOperations::filter_by_bit($LIST_OF_BINARY_NUMBERS, $position, $bit_Value);

		my $expected = [
			'00100',
			'10110',
			'10111',
			'10101',
			'00111',
			'10000',
			'00010',
		];

		cmp_deeply($actual, $expected, 'Binary number inverted');
	};
};

done_testing();
