part of 'store_locator_bloc.dart';

sealed class StoreLocatorState extends Equatable {
  const StoreLocatorState();
}

final class StoreLocatorInitial extends StoreLocatorState {
  @override
  List<Object> get props => [];
}



class StoreLocatorLoading extends StoreLocatorState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class StoreLocatorSuccess extends StoreLocatorState {
  final StoreLocatorModel storeLocatorModel;

  const StoreLocatorSuccess({required this.storeLocatorModel});

  @override
  List<Object> get props => [storeLocatorModel];
}

class StoreLocatorFailure extends StoreLocatorState {
  final String message;

  const StoreLocatorFailure({required this.message});

  @override
  List<Object> get props => [message];
}