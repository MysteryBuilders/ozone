import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozon/presentation/splash/bloc/splash_bloc/splash_event.dart';
import 'package:ozon/presentation/splash/bloc/splash_bloc/splash_state.dart';


class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    // Mapping events to state with emit
    on<InitializeVideo>((event, emit) {
      emit(SplashVideoPlaying()); // Emit SplashVideoPlaying state
    });

    on<VideoEnded>((event, emit) {
      emit(SplashVideoFinished()); // Emit SplashVideoFinished state
    });
  }
}
