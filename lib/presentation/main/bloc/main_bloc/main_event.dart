// Events
import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class MainChanged extends MainEvent {
  final int index;

  const MainChanged(this.index);

  @override
  List<Object> get props => [index];
}