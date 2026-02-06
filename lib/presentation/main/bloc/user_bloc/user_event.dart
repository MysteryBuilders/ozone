part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();
}
class UserInfoFetched extends UserEvent {
  final String authorization;


  const UserInfoFetched(this.authorization);

  @override
  List<Object> get props => [Random().nextDouble(),authorization];
}