part of 'delete_coupoun_bloc.dart';

sealed class DeleteCoupounEvent extends Equatable {
  const DeleteCoupounEvent();
}
class DeleteCoupounButtonPressed extends DeleteCoupounEvent {

  final String authorization;



  const DeleteCoupounButtonPressed({required this.authorization});

  @override
  List<Object> get props => [authorization];
}