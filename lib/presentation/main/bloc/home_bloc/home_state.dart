import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/home_screen_model.dart';
import '../../../../domain/model/home_model.dart';


abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {

}

class HomeSuccess extends HomeState {
  final ScreenHome screenHome;

  const HomeSuccess({required this.screenHome});

  @override
  List<Object> get props => [screenHome];
}

class HomeFailure extends HomeState {
  final String message;

  const HomeFailure({required this.message});

  @override
  List<Object> get props => [message];
}