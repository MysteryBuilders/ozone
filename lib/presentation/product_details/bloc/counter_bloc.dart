import 'package:bloc/bloc.dart';

import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(1)) {
    on<Increment>((event, emit) {
      if (state.count < event.maxCount) {
        emit(CounterState(state.count + 1));
      }
    });

    on<Decrement>((event, emit) {
      if (state.count > event.initalCount) {
        emit(CounterState(state.count - 1));
      }
    });
    on<InitialCountEvent>((event, emit) {

        emit(CounterState(event.initalCount ));

    });
  }
}
