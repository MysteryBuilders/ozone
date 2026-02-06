part of 'store_locator_bloc.dart';

sealed class StoreLocatorEvent extends Equatable {
  const StoreLocatorEvent();
}
class StoreLocatorFetched extends StoreLocatorEvent {

  final String authorization;
  final String country;
  final String state;


  const StoreLocatorFetched(this.authorization,this.country,this.state);

  @override
  List<Object> get props => [Random().nextDouble(),authorization,authorization,country,state];
}