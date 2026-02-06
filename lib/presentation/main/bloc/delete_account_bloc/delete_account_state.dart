part of 'delete_account_bloc.dart';

sealed class DeleteAccountState extends Equatable {
  const DeleteAccountState();
}

final class DeleteAccountInitial extends DeleteAccountState {
  @override
  List<Object> get props => [];
}

class DeleteAccountLoading extends DeleteAccountState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class DeleteAccountSuccess extends DeleteAccountState {
  final bool success;

  const DeleteAccountSuccess({required this.success});

  @override
  List<Object> get props => [success];
}

class DeleteAccountFailure extends DeleteAccountState {
  final String message;

  const DeleteAccountFailure({required this.message});

  @override
  List<Object> get props => [message];
}
