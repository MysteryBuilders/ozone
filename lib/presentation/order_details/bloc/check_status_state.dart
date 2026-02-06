part of 'check_status_bloc.dart';

sealed class CheckStatusState extends Equatable {
  const CheckStatusState();
}

final class CheckStatusInitial extends CheckStatusState {
  @override
  List<Object> get props => [];
}
final class CheckStatusSuccess extends CheckStatusState {
  final List<StatusModel> statusModel;

  const CheckStatusSuccess({required this.statusModel});

  @override
  List<Object> get props => [statusModel];
}
