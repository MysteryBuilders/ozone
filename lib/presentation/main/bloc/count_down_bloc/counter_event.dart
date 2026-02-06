abstract class CountdownEvent {}

class StartCountdown extends CountdownEvent {
  final int totalSeconds;

  StartCountdown(this.totalSeconds);
}
