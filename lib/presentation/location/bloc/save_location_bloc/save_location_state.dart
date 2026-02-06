part of 'save_location_bloc.dart';

sealed class SaveLocationState extends Equatable {
  const SaveLocationState();
}

final class SaveLocationInitial extends SaveLocationState {
  @override
  List<Object> get props => [];
}

class SaveLocationLoading extends SaveLocationState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class SaveLocationSuccess extends SaveLocationState {
  final LocationModel locationModel;


  SaveLocationSuccess({required this.locationModel});

  @override
  List<Object> get props => [locationModel];
}

class SaveLocationFailure extends SaveLocationState {
  final String message;

  SaveLocationFailure({required this.message});

  @override
  List<Object> get props => [message];
}