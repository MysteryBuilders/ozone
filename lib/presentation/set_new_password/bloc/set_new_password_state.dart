part of 'set_new_password_bloc.dart';

sealed class SetNewPasswordState extends Equatable {
  const SetNewPasswordState();
}

final class SetNewPasswordInitial extends SetNewPasswordState {
  @override
  List<Object> get props => [];
}

class SetNewPasswordLoading extends SetNewPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SetNewPasswordSuccess extends SetNewPasswordState {
  final bool isSuccess;

  const SetNewPasswordSuccess({required this.isSuccess});

  @override
  List<Object> get props => [isSuccess];
}

class SetNewPasswordFailure extends SetNewPasswordState {
  final String message;

  const SetNewPasswordFailure({required this.message});

  @override
  List<Object> get props => [message];
}


