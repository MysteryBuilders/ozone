import 'package:bloc/bloc.dart';
import 'package:location/location.dart';

import 'current_location_event.dart';
import 'current_location_state.dart';


class CurrentLocationBloc extends Bloc<CurrentLocationEvent, CurrentLocationState> {
  final Location _location = Location();


  CurrentLocationBloc() : super(CurrentLocationInitial()) {
    on<FetchLocation>(_onFetchLocation);
  }

  Future<void> _onFetchLocation(
      FetchLocation event, Emitter<CurrentLocationState> emit) async {
    emit(CurrentLocationLoading()); // Emit loading state

    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        await Future.delayed(Duration(seconds: 1));
        if (!serviceEnabled) {
          emit(CurrentLocationFailure("Location services are still disabled."));
          return;
        }
      }

      PermissionStatus permission = await _location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await _location.requestPermission();
        if (permission == PermissionStatus.denied) {
          emit(CurrentLocationFailure("Location permission denied."));
          return;
        }
      }

      if (permission == PermissionStatus.deniedForever) {
        emit(CurrentLocationFailure("Location permission permanently denied. Please enable it in settings."));
        return;
      }

      LocationData position = await _location.getLocation();


      emit(CurrentLocationSuccess(latitude: position.latitude!, longitude: position.longitude!));
    } catch (e) {
      emit(CurrentLocationFailure("Error fetching location: $e"));
    }
  }
}
