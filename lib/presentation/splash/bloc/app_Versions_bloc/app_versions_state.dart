part of 'app_versions_bloc.dart';

sealed class AppVersionsState extends Equatable {
  const AppVersionsState();
}

final class AppVersionsInitial extends AppVersionsState {
  @override
  List<Object> get props => [];
}
class AppVersionsLoading extends AppVersionsState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class AppVersionsSuccess extends AppVersionsState {
  final AppVersionModel appVersionModel;

  const AppVersionsSuccess({required this.appVersionModel});

  @override
  List<Object> get props => [appVersionModel];
}

class AppVersionsStateFailure extends AppVersionsState {
  final String message;

  const AppVersionsStateFailure({required this.message});

  @override
  List<Object> get props => [message];
}