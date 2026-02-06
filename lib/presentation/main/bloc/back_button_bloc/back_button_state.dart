part of 'back_button_bloc.dart';

class BackButtonState extends Equatable {
  final bool showBackButton;
  final String title;

  const BackButtonState(this.showBackButton,this.title);

  @override
  List<Object> get props => [showBackButton,title];
}