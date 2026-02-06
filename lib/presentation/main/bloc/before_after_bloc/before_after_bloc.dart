import 'package:bloc/bloc.dart';

import 'before_after_event.dart';
import 'before_after_state.dart';

class BeforeAfterBloc extends Bloc<BeforeAfterEvent, BeforeAfterState> {
  BeforeAfterBloc() : super(ValueChangedState(0.5)) { // Initial value
    on<UpdateValue>((event, emit) {
      emit(ValueChangedState(event.newValue));
    });
  }
}
