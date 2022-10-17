#!/usr/bin/perl

use Test2::V0;

use lib 'lib';

use Crabs::FuelUsage::Exponential;

subtest 'new' => sub {
    my $fuel_usage_strategy = Crabs::FuelUsage::Exponential->new();

    DOES_ok(
        $fuel_usage_strategy,
        ['Crabs::FuelUsage::Interface'],
        'has the role Crabs::FuelUsage::Interface'
    );
};

subtest
    'calculate_fuel_usage should return 1 more fuel unit per 1 unit of movement'
    => sub {
    my %cases = (
        1  => 1,
        5  => 15,
        11 => 66,
    );

    while ( my ( $distance, $expected_fuel_usage ) = each %cases ) {
        _execute_fuel_usage_calculation_test( $distance, $expected_fuel_usage,
            "Calculate fuel usage for distance: $distance" );
    }

    };

done_testing();

sub _execute_fuel_usage_calculation_test {
    my $distance            = shift;
    my $expected_fuel_usage = shift;
    my $test_description    = shift;

    my $fuel_usage_strategy = Crabs::FuelUsage::Exponential->new();

    my $actual_fuel_usage
        = $fuel_usage_strategy->calculate_fuel_usage($distance);

    is( $actual_fuel_usage, $expected_fuel_usage, $test_description );
}
