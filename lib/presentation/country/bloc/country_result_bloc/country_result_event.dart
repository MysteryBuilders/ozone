

import 'dart:math';

import 'package:equatable/equatable.dart';

import '../../../../domain/model/country_model.dart';

sealed class CountryResultEvent extends Equatable {
  const CountryResultEvent();
}
class SelectCountryResultFetch extends CountryResultEvent {
  final CountryModel country;

  SelectCountryResultFetch(this.country);

  @override
  List<Object> get props => [country];
}
class ResetCountryReultFetch extends CountryResultEvent {


  ResetCountryReultFetch();

  @override
  List<Object> get props => [Random().nextDouble()];
}