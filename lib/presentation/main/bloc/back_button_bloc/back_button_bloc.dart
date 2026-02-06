import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'back_button_event.dart';
part 'back_button_state.dart';

class BackButtonBloc extends Bloc<BackButtonEvent, BackButtonState> {
  BackButtonBloc() : super(const BackButtonState(true,"")) {
    on<UpdateBackButtonEvent>((event, emit) {
      emit(BackButtonState(event.showBackButton,event.title));
    });
  }
}