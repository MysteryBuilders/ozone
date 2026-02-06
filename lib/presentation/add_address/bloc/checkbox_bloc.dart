import 'package:flutter_bloc/flutter_bloc.dart';

import 'checkbox_event.dart';
import 'checkbox_state.dart';

class CheckboxBloc extends Bloc<CheckboxEvent, CheckboxState> {
  CheckboxBloc() : super(const CheckboxState(isChecked: false)) {
    on<ToggleCheckboxEvent>((event, emit) {
      // Toggle the checkbox state
      emit(CheckboxState(isChecked: !state.isChecked));
    });
    on<InitCheckboxEvent>((event, emit) {
      // Toggle the checkbox state
      emit(CheckboxState(isChecked: event.isChecked));
    });
  }
}
