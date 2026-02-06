import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_event.dart';
import 'counter_state.dart';


class CountdownBloc extends Bloc<CountdownEvent, CountdownState> {
  CountdownBloc()
      : super(CountdownState(days: 0, hours: 0, minutes: 0, seconds: 0)) {
    on<StartCountdown>(_onStartCountdown);
  }

  Stream<int> _tick(int totalSeconds) {
    return Stream.periodic(
      Duration(seconds: 1),
          (x) => totalSeconds - x,
    ).takeWhile((remainingSeconds) => remainingSeconds >= 0);
  }

  Future<void> _onStartCountdown(
      StartCountdown event, Emitter<CountdownState> emit) async {
    await emit.forEach<int>(
      _tick(event.totalSeconds),
      onData: (remainingSeconds) {
        return CountdownState.fromSeconds(remainingSeconds);
      },
    );
  }
}
