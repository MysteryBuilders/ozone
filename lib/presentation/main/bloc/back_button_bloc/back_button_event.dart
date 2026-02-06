part of 'back_button_bloc.dart';

sealed class BackButtonEvent extends Equatable {
  const BackButtonEvent();
}

class UpdateBackButtonEvent extends BackButtonEvent {
  final bool showBackButton;
  final String title;

  const UpdateBackButtonEvent(this.showBackButton,this.title);

  @override
  List<Object> get props => [showBackButton,title];
}
