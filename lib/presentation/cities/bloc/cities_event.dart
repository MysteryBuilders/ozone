part of 'cities_bloc.dart';

sealed class CitiesEvent extends Equatable {
  const CitiesEvent();
}
class CitiesFetched extends CitiesEvent {
  final String stateName;


  const CitiesFetched(this.stateName);

  @override
  List<Object> get props => [Random().nextDouble(),stateName];
}
class InitCities extends CitiesEvent {


  InitCities();

  @override
  List<Object> get props => [];
}

class SelectCity extends CitiesEvent {
  final CityModel cityModel;

  SelectCity(this.cityModel);

  @override
  List<Object> get props => [cityModel];
}
class SearchCities extends CitiesEvent {
  final String query;

  SearchCities(this.query);

  @override
  List<Object> get props => [query];
}