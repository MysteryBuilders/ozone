part of 'delete_account_bloc.dart';

sealed class DeleteAccountEvent extends Equatable {
  const DeleteAccountEvent();
}

class DeleteAccountButtonPressed extends DeleteAccountEvent{
  final int userId;
  final String authorization;



  const DeleteAccountButtonPressed({required this.userId,required this.authorization});

  @override
  List<Object> get props => [userId,authorization];
}