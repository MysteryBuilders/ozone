// Splash Events
import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
  @override
  List<Object> get props => [];
}

class InitializeVideo extends SplashEvent {}

class VideoEnded extends SplashEvent {}
