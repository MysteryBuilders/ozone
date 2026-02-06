import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'title_event.dart';
part 'title_state.dart';

class TitleBloc extends Bloc<TitleEvent, TitleState> {
  TitleBloc() : super(TitleInitial()) {
    on<TitleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
