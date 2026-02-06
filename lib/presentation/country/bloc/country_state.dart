part of 'country_bloc.dart';

sealed class CountryState extends Equatable {
  const CountryState();
}

final class CountryInitial extends CountryState {
  @override
  List<Object> get props => [];
}

class CountryLoading extends CountryState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class CountrySuccess extends CountryState {
  final List<CountryModel> categoryModel;
  final CountryModel countryModel;

  const CountrySuccess({required this.categoryModel,required this.countryModel});

  @override
  List<Object> get props => [categoryModel,countryModel];
}

class CountryFailure extends CountryState {
  final String message;

  const CountryFailure({required this.message});

  @override
  List<Object> get props => [message];
}
