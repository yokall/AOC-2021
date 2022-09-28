package DayThree::DiagnosticOperations;

use strict;
use warnings;

use DayThree::BinaryOperations;

sub calculate_gamma_rate {
	my $list_of_binary_numbers = shift;

	my $lcb_binary_number = DayThree::BinaryOperations::create_binary_number_from_least_common_bit($list_of_binary_numbers);
	my $mcb_binary_number = DayThree::BinaryOperations::invert_binary_number($lcb_binary_number);

	return DayThree::BinaryOperations::binary_to_decimal($mcb_binary_number);
}

sub calculate_epsilon_rate {
	my $list_of_binary_numbers = shift;

	my $lcb_binary_number = DayThree::BinaryOperations::create_binary_number_from_least_common_bit($list_of_binary_numbers);

	return DayThree::BinaryOperations::binary_to_decimal($lcb_binary_number);
}

sub calculate_power_consumption {
	my $list_of_binary_numbers = shift;

	my $gamma_rate = calculate_gamma_rate($list_of_binary_numbers);
	my $epsilon_rate = calculate_epsilon_rate($list_of_binary_numbers);

	return $gamma_rate * $epsilon_rate;
}

sub calculate_co2_rating {
	my $list_of_binary_numbers = shift;

	for (my $i = 0 ; $i < length($list_of_binary_numbers->[0]) ; $i++) {
		$list_of_binary_numbers = _filter_list_by_least_common_bit_at($list_of_binary_numbers, $i);

		last if scalar(@{$list_of_binary_numbers}) eq 1;
	}

	return DayThree::BinaryOperations::binary_to_decimal($list_of_binary_numbers->[0]);
}

sub _filter_list_by_least_common_bit_at {
	my $list_of_binary_numbers = shift;
	my $position = shift;

	my $least_common_bit = DayThree::BinaryOperations::create_binary_number_from_least_common_bit($list_of_binary_numbers, $position);

	$list_of_binary_numbers = DayThree::BinaryOperations::filter_by_bit($list_of_binary_numbers, $position, $least_common_bit);
}

sub calculate_oxygen_rating {
	my $list_of_binary_numbers = shift;

	for (my $i = 0 ; $i < length($list_of_binary_numbers->[0]) ; $i++) {
		$list_of_binary_numbers = _filter_list_by_most_common_bit_at($list_of_binary_numbers, $i);

		last if scalar(@{$list_of_binary_numbers}) eq 1;
	}

	return DayThree::BinaryOperations::binary_to_decimal($list_of_binary_numbers->[0]);
}

sub _filter_list_by_most_common_bit_at {
	my $list_of_binary_numbers = shift;
	my $position = shift;

	my $least_common_bit = DayThree::BinaryOperations::create_binary_number_from_least_common_bit($list_of_binary_numbers, $position);
	my $most_common_bit = $least_common_bit ? 0 : 1;

	$list_of_binary_numbers = DayThree::BinaryOperations::filter_by_bit($list_of_binary_numbers, $position, $most_common_bit);
}

sub calculate_life_support_rating {
	my $list_of_binary_numbers = shift;

	my $co2_rating = calculate_co2_rating($list_of_binary_numbers);
	my $oxygen_rating = calculate_oxygen_rating($list_of_binary_numbers);

	return $co2_rating * $oxygen_rating;
}

1;
