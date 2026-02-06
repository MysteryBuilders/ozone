part of 'new_splash_bloc.dart';

sealed class NewSplashEvent extends Equatable {
  const NewSplashEvent();
}
class NewSplashFetched extends NewSplashEvent {



  const NewSplashFetched();

  @override
  List<Object> get props => [Random().nextDouble()];
}
class SplashTimeoutFinished extends NewSplashEvent {
  @override
  // TODO: implement props
  List<Object?> get props =>[Random().nextDouble()];
}