part of 'app_versions_bloc.dart';

sealed class AppVersionsEvent extends Equatable {
  const AppVersionsEvent();
}
class AppVersionsFetched extends AppVersionsEvent {
  final String authorization;


  const AppVersionsFetched(this.authorization);

  @override
  List<Object> get props => [Random().nextDouble(),authorization];
}