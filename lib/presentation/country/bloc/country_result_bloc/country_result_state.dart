

import 'package:equatable/equatable.dart';

import '../../../../domain/model/country_model.dart';
class CountryResultState extends Equatable {
  const CountryResultState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class CountryInitial extends CountryResultState {
  @override
  List<Object> get props => [];
}
class CountryResultStateSuccess extends CountryResultState {
  final CountryModel countryModel;

  const CountryResultStateSuccess( {required this.countryModel});

  @override
  List<Object> get props => [countryModel];
}