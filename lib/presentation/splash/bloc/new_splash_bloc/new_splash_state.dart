part of 'new_splash_bloc.dart';

sealed class NewSplashState extends Equatable {
  const NewSplashState();
}

final class NewSplashInitial extends NewSplashState {
  @override
  List<Object> get props => [];
}
class NewSplashLoading extends NewSplashState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class NewSplashSuccess extends NewSplashState {
  final SplashModel splashModel;
  final bool isSplashFinishedLoading;

  const NewSplashSuccess({required this.splashModel,required this.isSplashFinishedLoading});

  @override
  List<Object> get props => [splashModel,isSplashFinishedLoading];
}

class NewSplashFailure extends NewSplashState {
  final String message;

  const NewSplashFailure({required this.message});

  @override
  List<Object> get props => [message];
}
