part of 'cities_bloc.dart';

sealed class CitiesState extends Equatable {
  const CitiesState();
}

final class CitiesInitial extends CitiesState {
  @override
  List<Object> get props => [];
}

class CitiesLoading extends CitiesState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class CitiesSuccess extends CitiesState {
  final List<CityModel> citiesModel;
  final CityModel selectedCity;
  const CitiesSuccess({required this.citiesModel,required this.selectedCity});

  @override
  List<Object> get props => [citiesModel,selectedCity];
}

class CitiesFailure extends CitiesState {
  final String message;

  const CitiesFailure({required this.message});

  @override
  List<Object> get props => [message];
}
