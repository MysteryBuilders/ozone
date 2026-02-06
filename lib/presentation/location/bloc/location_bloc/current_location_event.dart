import 'package:equatable/equatable.dart';

abstract class CurrentLocationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchLocation extends CurrentLocationEvent {}
