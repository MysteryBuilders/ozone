import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/new_login_model.dart';





abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final NewLoginModel newLoginModel;

  const LoginSuccess({required this.newLoginModel});

  @override
  List<Object> get props => [newLoginModel];
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure({required this.message});

  @override
  List<Object> get props => [message];
}
