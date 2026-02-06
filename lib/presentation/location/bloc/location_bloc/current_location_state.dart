abstract class CurrentLocationState {}

class CurrentLocationInitial extends CurrentLocationState {}

class CurrentLocationLoading extends CurrentLocationState {}

class CurrentLocationSuccess extends CurrentLocationState {
  final double latitude;
  final double longitude;

  CurrentLocationSuccess({required this.latitude, required this.longitude});
}

class CurrentLocationFailure extends CurrentLocationState {
  final String error;

  CurrentLocationFailure(this.error);
}
