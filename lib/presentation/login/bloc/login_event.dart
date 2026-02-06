import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  final   String authorization;


  const LoginButtonPressed({required this.email,required this.password,required this.authorization});

  @override
  List<Object> get props => [email,password];
}