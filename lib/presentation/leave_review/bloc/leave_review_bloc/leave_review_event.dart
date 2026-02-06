part of 'leave_review_bloc.dart';

sealed class LeaveReviewEvent extends Equatable {
  const LeaveReviewEvent();
}
class LeaveReviewButtonPressed extends LeaveReviewEvent {

  final String authorization;
  final Map<String,dynamic> map;



  const LeaveReviewButtonPressed({required this.authorization,required this.map});

  @override
  List<Object> get props => [map,authorization];
}