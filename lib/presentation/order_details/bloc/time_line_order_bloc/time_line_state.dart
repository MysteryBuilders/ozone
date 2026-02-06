part of 'time_line_bloc.dart';

sealed class TimeLineState extends Equatable {
  const TimeLineState();
}

final class TimeLineInitial extends TimeLineState {
  @override
  List<Object> get props => [];
}
class  TimeLineLoading extends TimeLineState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class  TimeLineSuccess extends TimeLineState {
  final TimeLine timeLine;

  const TimeLineSuccess({required this.timeLine});

  @override
  List<Object> get props => [timeLine];
}

class  TimeLineFailure extends TimeLineState {
  final String message;

  const TimeLineFailure({required this.message});

  @override
  List<Object> get props => [message];
}