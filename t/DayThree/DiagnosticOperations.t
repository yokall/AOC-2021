#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

use_ok('DayThree::DiagnosticOperations');

my $DIAGNOSTIC_OUTPUT = [
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

subtest 'calculate_gamma_rate' => sub {
	subtest 'should return the gamma rate based on diagnostic output' => sub {
		my $actual = DayThree::DiagnosticOperations::calculate_gamma_rate($DIAGNOSTIC_OUTPUT);

		my $expected = 22;

		is($actual, $expected, 'Calculate gamma rate');
	};
};

subtest 'calculate_epsilon_rate' => sub {
	subtest 'should return the epsilon rate based on diagnostic output' => sub {
		my $actual = DayThree::DiagnosticOperations::calculate_epsilon_rate($DIAGNOSTIC_OUTPUT);

		my $expected = 9;

		is($actual, $expected, 'Calculate epsilon rate');
	};
};

subtest 'calculate_power_consumption' => sub {
	subtest 'should return the power consumption of the sub based on the diagnostic output' => sub {
		my $actual = DayThree::DiagnosticOperations::calculate_power_consumption($DIAGNOSTIC_OUTPUT);

		my $expected = 198;

		is($actual, $expected, 'Calculate power consumption');
	};
};

subtest 'calculate_co2_rating' => sub {
	subtest 'should return the CO2 rating based on diagnostic output' => sub {
		my $actual = DayThree::DiagnosticOperations::calculate_co2_rating($DIAGNOSTIC_OUTPUT);

		my $expected = 10;

		is($actual, $expected, 'Calculate CO2 rating');
	};
};

subtest 'calculate_oxygen_rating' => sub {
	subtest 'should return the oxygen rating based on diagnostic output' => sub {
		my $actual = DayThree::DiagnosticOperations::calculate_oxygen_rating($DIAGNOSTIC_OUTPUT);

		my $expected = 23;

		is($actual, $expected, 'Calculate oxygen rating');
	};
};

subtest 'calculate_life_support_rating' => sub {
	subtest 'should return the life support rating of the sub based on the diagnostic output' => sub {
		my $actual = DayThree::DiagnosticOperations::calculate_life_support_rating($DIAGNOSTIC_OUTPUT);

		my $expected = 230;

		is($actual, $expected, 'Calculate life support rating');
	};
};

done_testing();
