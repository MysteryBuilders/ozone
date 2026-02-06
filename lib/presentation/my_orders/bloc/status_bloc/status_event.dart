part of 'status_bloc.dart';


abstract class StatusEvent extends Equatable {
  const StatusEvent();

  @override
  List<Object> get props => [];
}

class StatusChanged extends StatusEvent {
  final int index;

  const StatusChanged(this.index);

  @override
  List<Object> get props => [index];
}