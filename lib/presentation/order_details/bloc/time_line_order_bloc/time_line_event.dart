part of 'time_line_bloc.dart';

sealed class TimeLineEvent extends Equatable {
  const TimeLineEvent();
}
class TimeLineFetched extends TimeLineEvent {

  String authorization;
  String orderId;



  TimeLineFetched(this.authorization,this.orderId);

  @override
  List<Object> get props => [this.authorization,this.orderId];
}