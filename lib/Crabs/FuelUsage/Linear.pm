package Crabs::FuelUsage::Linear;

use Moose;
with 'Crabs::FuelUsage::Interface';

sub calculate_fuel_usage {
    my ( $self, $distance ) = @_;

    return $distance;
}

1;
