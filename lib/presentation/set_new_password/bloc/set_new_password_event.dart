part of 'set_new_password_bloc.dart';

sealed class SetNewPasswordEvent extends Equatable {
  const SetNewPasswordEvent();
}

class UpdatePasswordButtonPressed extends SetNewPasswordEvent {
  final String newPassword;
  final String confirmNewPassword;
  final String currentPassword;
  final   String authorization;


  const UpdatePasswordButtonPressed({required this.newPassword,required this.confirmNewPassword,required this.currentPassword,required this.authorization});

  @override
  List<Object> get props => [newPassword,confirmNewPassword,currentPassword,authorization];
}