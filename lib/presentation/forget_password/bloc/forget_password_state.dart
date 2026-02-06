import 'package:equatable/equatable.dart';





abstract class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {
  final bool success;

  const ForgetPasswordSuccess({required this.success});

  @override
  List<Object> get props => [success];
}

class ForgetPasswordFailure extends ForgetPasswordState {
  final String message;

  const ForgetPasswordFailure({required this.message});

  @override
  List<Object> get props => [message];
}
