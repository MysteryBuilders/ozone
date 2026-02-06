part of 'check_status_bloc.dart';

sealed class CheckStatusEvent extends Equatable {
  const CheckStatusEvent();
}
class CheckStatusFetched extends CheckStatusEvent {
  final String  status;
  final List<StatusModel> statusList;

  const CheckStatusFetched(this.status,this.statusList);

  @override
  List<Object> get props => [status,this.statusList];
}