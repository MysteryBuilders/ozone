part of 'country_bloc.dart';

sealed class CountryEvent extends Equatable {
  const CountryEvent();
}

class CountriesFetched extends CountryEvent {
  final String authorization;


  const CountriesFetched(this.authorization);

  @override
  List<Object> get props => [Random().nextDouble(),authorization];
}

class SelectCountry extends CountryEvent {
  final CountryModel country;

  SelectCountry(this.country);

  @override
  List<Object> get props => [country];
}
class ResetCountry extends CountryEvent {


  ResetCountry();

  @override
  List<Object> get props => [];
}
class SearchCountries extends CountryEvent {
  final String query;

  SearchCountries(this.query);

  @override
  List<Object> get props => [query];
}