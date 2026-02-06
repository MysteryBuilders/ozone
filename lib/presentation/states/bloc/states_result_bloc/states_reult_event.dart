part of 'states_reult_bloc.dart';

sealed class StatesReultEvent extends Equatable {
  const StatesReultEvent();
}
class SelectStatesReultFetch extends StatesReultEvent {
  final StateModel stateModel;

  SelectStatesReultFetch(this.stateModel);

  @override
  List<Object> get props => [stateModel];
}

class ResetStatesReultFetch extends StatesReultEvent {


  ResetStatesReultFetch();

  @override
  List<Object> get props => [Random().nextDouble()];
}