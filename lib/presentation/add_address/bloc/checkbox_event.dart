import 'package:equatable/equatable.dart';

abstract class CheckboxEvent extends Equatable {
  const CheckboxEvent();

  @override
  List<Object> get props => [];
}

class ToggleCheckboxEvent extends CheckboxEvent {}
class InitCheckboxEvent extends CheckboxEvent{
  bool isChecked;
  InitCheckboxEvent(this.isChecked);
  @override
  List<Object> get props => [isChecked];
}