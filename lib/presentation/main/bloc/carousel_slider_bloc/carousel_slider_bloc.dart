import 'package:flutter_bloc/flutter_bloc.dart';

import 'carousel_slider_event.dart';
import 'carousel_slider_state.dart';

class CarouselSLiderBloc extends Bloc<CarouselSLiderEvent, CarouselSLiderState> {
  CarouselSLiderBloc() : super(CarouselSLiderState(0)) {
    on<PageChangedEvent>((event, emit) {
      emit(CarouselSLiderState(event.newIndex));
    });
  }
}