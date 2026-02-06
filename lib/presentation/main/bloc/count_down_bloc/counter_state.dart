class CountdownState {
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  CountdownState({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  factory CountdownState.fromSeconds(int totalSeconds) {
    int days = totalSeconds ~/ (24 * 3600);
    totalSeconds %= (24 * 3600);
    int hours = totalSeconds ~/ 3600;
    totalSeconds %= 3600;
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;

    return CountdownState(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }
}
