part of 'save_location_bloc.dart';

sealed class SaveLocationEvent extends Equatable {
  const SaveLocationEvent();
}
class SaveLocationFetched extends SaveLocationEvent {
  Map<String,dynamic> map;
  String authorization;



  SaveLocationFetched(this.map,this.authorization);

  @override
  List<Object> get props => [map,authorization];
}