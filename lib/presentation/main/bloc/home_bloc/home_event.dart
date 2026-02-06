import 'dart:math';

import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}
class HomeFetched extends HomeEvent {
  final String authorization;


  const HomeFetched(this.authorization);

  @override
  List<Object> get props => [Random().nextDouble(),authorization];
}
