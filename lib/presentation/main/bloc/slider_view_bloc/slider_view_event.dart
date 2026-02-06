part of 'slider_view_bloc.dart';

sealed class SliderViewEvent extends Equatable {
  const SliderViewEvent();
}
class SliderViewFetched extends SliderViewEvent {
  final bool isSliderOpen;

  const SliderViewFetched(this.isSliderOpen);

  @override
  List<Object> get props => [isSliderOpen];
}