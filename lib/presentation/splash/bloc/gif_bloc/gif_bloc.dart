import 'package:flutter_bloc/flutter_bloc.dart';

import 'gif_event.dart';
import 'gif_state.dart';

class GifBloc extends Bloc<GifEvent, GifState> {
  GifBloc() : super(GifInitial()) {
    on<GifStarted>((event, emit) => emit(GifPlaying()));
    on<GifCompleted>((event, emit) => emit(GifFinished()));
  }
}