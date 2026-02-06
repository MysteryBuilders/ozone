import 'package:bloc/bloc.dart';

import 'caursel_event.dart';
import 'caursel_state.dart';

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  CarouselBloc() : super(CarouselState(0)) {
    // Event handlers
    on<MoveNext>((event, emit) {
      emit(CarouselState((state.currentIndex + 1) % event.itemCount));
    });

    on<MovePrevious>((event, emit) {
      emit(CarouselState((state.currentIndex - 1 + event.itemCount) % event.itemCount));
    });

    on<MoveToIndex>((event, emit) {
      if (event.index >= 0 && event.index < event.itemCount) {
        emit(CarouselState(event.index));
      }
    });
  }
}
