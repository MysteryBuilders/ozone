part of 'default_city_bloc.dart';

@immutable
sealed class DefaultCityEvent {}
class DefaultCityFetched extends DefaultCityEvent {



  DefaultCityFetched();

  @override
  List<Object> get props => [Random().nextDouble()];
}