part of 'slider_view_bloc.dart';



class SliderViewState extends Equatable {
  final bool isSliderOpen;

  const SliderViewState( {this.isSliderOpen = false});

  @override
  List<Object> get props => [isSliderOpen];
}
