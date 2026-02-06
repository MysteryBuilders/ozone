import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String authorization;
  final String phoneNumber;
  final String countryCode;
  final String stateId;
  final String storeCode;


  const RegisterButtonPressed({required this.email,required this.firstName,required this.lastName,required this.password,required this.authorization,required this.phoneNumber,required this.countryCode,required this.stateId,required this.storeCode});

  @override
  List<Object> get props => [email,firstName,lastName,password];
}