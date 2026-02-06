abstract class BeforeAfterEvent {}

class UpdateValue extends BeforeAfterEvent {
  final double newValue;

  UpdateValue(this.newValue);
}
