part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();
}

final class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}
class UserLoading extends UserState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserSuccess extends UserState {
  final UserInfoModel userInfoModel;

  const UserSuccess({required this.userInfoModel});

  @override
  List<Object> get props => [userInfoModel];
}

class UserFailure extends UserState {
  final String message;

  const UserFailure({required this.message});

  @override
  List<Object> get props => [message];
}

