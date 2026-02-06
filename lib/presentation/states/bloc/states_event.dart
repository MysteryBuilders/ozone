part of 'states_bloc.dart';

sealed class StatesEvent extends Equatable {
  const StatesEvent();
}
class StatesFetched extends StatesEvent {
  final String countryCode;


  const StatesFetched(this.countryCode);

  @override
  List<Object> get props => [Random().nextDouble(),countryCode];
}
class InitStates extends StatesEvent {


  InitStates();

  @override
  List<Object> get props => [];
}
class SelectStates extends StatesEvent {
  final StateModel stateModel;

  SelectStates(this.stateModel);

  @override
  List<Object> get props => [stateModel];
}
class SearchStates extends StatesEvent {
  final String query;

  SearchStates(this.query);

  @override
  List<Object> get props => [query];
}