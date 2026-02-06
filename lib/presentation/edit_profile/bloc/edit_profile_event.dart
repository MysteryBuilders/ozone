part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();
}

class EditProfileButtonPressed extends EditProfileEvent {
  final String email;
  final String password;
  final   String authorization;


  const EditProfileButtonPressed({required this.email,required this.password,required this.authorization});

  @override
  List<Object> get props => [email,password,authorization];
}