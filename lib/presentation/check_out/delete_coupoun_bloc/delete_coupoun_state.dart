part of 'delete_coupoun_bloc.dart';

sealed class DeleteCoupounState extends Equatable {
  const DeleteCoupounState();
}

final class DeleteCoupounInitial extends DeleteCoupounState {
  @override
  List<Object> get props => [];
}

class DeleteCoupounLoading extends DeleteCoupounState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class DeleteCoupounSuccess extends DeleteCoupounState {
  final bool success;

  const DeleteCoupounSuccess({required this.success});

  @override
  List<Object> get props => [success];
}

class DeleteCoupounFailure extends DeleteCoupounState {
  final String message;

  const DeleteCoupounFailure({required this.message});

  @override
  List<Object> get props => [message];
}

