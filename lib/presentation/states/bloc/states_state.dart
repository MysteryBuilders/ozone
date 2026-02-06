part of 'states_bloc.dart';

sealed class StatesState extends Equatable {
  const StatesState();
}

final class StatesInitial extends StatesState {
  @override
  List<Object> get props => [];
}
class StatesLoading extends StatesState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class StatesSuccess extends StatesState {
  final List<StateModel> statesList;
  final StateModel selectState;

  const StatesSuccess({required this.statesList,required this.selectState});

  @override
  List<Object> get props => [statesList,selectState];
}

class StatesFailure extends StatesState {
  final String message;

  const StatesFailure({required this.message});

  @override
  List<Object> get props => [message];
}
