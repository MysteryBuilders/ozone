import 'package:equatable/equatable.dart';

abstract class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgetPasswordButtonPressed extends ForgetPasswordEvent {
  final String email;
  final String authorization;



  const ForgetPasswordButtonPressed({required this.email,required this.authorization});

  @override
  List<Object> get props => [email,authorization];
}