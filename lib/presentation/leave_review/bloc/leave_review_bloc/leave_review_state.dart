part of 'leave_review_bloc.dart';

sealed class LeaveReviewState extends Equatable {
  const LeaveReviewState();
}

final class LeaveReviewInitial extends LeaveReviewState {
  @override
  List<Object> get props => [];
}
class LeaveReviewLoading extends LeaveReviewState {
  const LeaveReviewLoading();

  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}
class LeaveReviewSuccess extends LeaveReviewState {
  final RatingModel ratingModel;

  const LeaveReviewSuccess({required this.ratingModel});

  @override
  List<Object> get props => [ratingModel];
}

class LeaveReviewFailure extends LeaveReviewState {
  final String message;

  const LeaveReviewFailure({required this.message});

  @override
  List<Object> get props => [message];
}
