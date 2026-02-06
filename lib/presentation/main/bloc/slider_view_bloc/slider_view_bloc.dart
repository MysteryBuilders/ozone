import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'slider_view_event.dart';
part 'slider_view_state.dart';



class SliderViewBloc extends Bloc<SliderViewEvent, SliderViewState> {
  SliderViewBloc() : super(const SliderViewState()) {
    on<SliderViewFetched>((event, emit) {
      emit(SliderViewState(isSliderOpen:event.isSliderOpen));
    });
  }
}
