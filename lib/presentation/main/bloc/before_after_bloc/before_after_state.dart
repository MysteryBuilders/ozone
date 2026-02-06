abstract class BeforeAfterState {}

class ValueChangedState extends BeforeAfterState {
  final double value;

  ValueChangedState(this.value);
}
