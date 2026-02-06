import 'dart:math';

import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class CategoriesFetched extends CategoriesEvent {
  final String authorization;


  const CategoriesFetched(this.authorization);

  @override
  List<Object> get props => [Random().nextDouble(),authorization];
}