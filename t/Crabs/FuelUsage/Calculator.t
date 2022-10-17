#!/usr/bin/perl

use Test2::V0;

use lib 'lib';

use Crabs::FuelUsage::Calculator;
use Crabs::FuelUsage::Exponential;
use Crabs::FuelUsage::Linear;

subtest
    'calculate_most_fuel_efficient_position should return the position that requires the least fuel usage for all crabs to converge on'
    => sub {
    my $starting_positions = [ 16, 1, 2, 0, 4, 2, 7, 1, 2, 14 ];

    subtest 'using the linear strategy' => sub {
        my $fuel_usage_calculator = Crabs::FuelUsage::Calculator->new(
            strategy => Crabs::FuelUsage::Linear->new() );

        my $actual_least_fuel_usage
            = $fuel_usage_calculator->calculate_most_fuel_efficient_position(
            $starting_positions);

        my $expected_least_fuel_usage = 37;

        is( $actual_least_fuel_usage, $expected_least_fuel_usage );
    };

    subtest 'using the exponential strategy' => sub {
        my $fuel_usage_calculator = Crabs::FuelUsage::Calculator->new(
            strategy => Crabs::FuelUsage::Exponential->new() );

        my $actual_least_fuel_usage
            = $fuel_usage_calculator->calculate_most_fuel_efficient_position(
            $starting_positions);

        my $expected_least_fuel_usage = 168;

        is( $actual_least_fuel_usage, $expected_least_fuel_usage );
    };

    };

done_testing();
