part of 'edit_profile_bloc.dart';

sealed class EditProfileState extends Equatable {
  const EditProfileState();
}

final class EditProfileInitial extends EditProfileState {
  @override
  List<Object> get props => [];
}
class EditProfileLoading extends EditProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EditProfileSuccess extends EditProfileState {
  final bool isSuccess;

  const EditProfileSuccess({required this.isSuccess});

  @override
  List<Object> get props => [isSuccess];
}

class EditProfileFailure extends EditProfileState {
  final String message;

  const EditProfileFailure({required this.message});

  @override
  List<Object> get props => [message];
}

