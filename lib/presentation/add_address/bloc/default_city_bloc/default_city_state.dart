part of 'default_city_bloc.dart';

@immutable
sealed class DefaultCityState {}

final class DefaultCityInitial extends DefaultCityState {}
class DefaultCityLoading extends DefaultCityState {

DefaultCityLoading();
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class DefaultCitySuccess extends DefaultCityState {
final CountryModel mCountryModel;
final StateModel mStateModel;

   DefaultCitySuccess({required this.mCountryModel,required this.mStateModel});

  @override
  List<Object> get props => [mCountryModel,mStateModel];
}

class DefaultCityFailure extends DefaultCityState {
  final String message;

   DefaultCityFailure({required this.message});

  @override
  List<Object> get props => [message,];
}
