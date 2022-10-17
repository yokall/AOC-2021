package Crabs::FuelUsage::Exponential;

use Moose;
with 'Crabs::FuelUsage::Interface';

sub calculate_fuel_usage {
    my ( $self, $distance ) = @_;

    my $fuel_usage = 0;
    foreach my $step ( 1 .. $distance ) {
        $fuel_usage += $step;
    }

    return $fuel_usage;
}

1;
