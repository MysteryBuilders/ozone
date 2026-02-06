part of 'states_reult_bloc.dart';

sealed class StatesReultState extends Equatable {
  const StatesReultState();
}

final class StatesReultInitial extends StatesReultState {
  @override
  List<Object> get props => [];
}

class StatesResultStateSuccess extends StatesReultState {
  final StateModel stateModel;

  const StatesResultStateSuccess( {required this.stateModel});

  @override
  List<Object> get props => [stateModel];
}