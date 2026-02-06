

import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/register_model.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterModel registerModel;

  const RegisterSuccess({required this.registerModel});

  @override
  List<Object> get props => [registerModel];
}

class RegisterFailure extends RegisterState {
  final String message;

  const RegisterFailure({required this.message});

  @override
  List<Object> get props => [message];
}
