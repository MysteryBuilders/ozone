part of 'my_orders_bloc.dart';

sealed class MyOrdersState extends Equatable {
  const MyOrdersState();
}

final class MyOrdersInitial extends MyOrdersState {
  @override
  List<Object> get props => [];
}

class  MyOrdersLoading extends MyOrdersState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class  MyOrdersSuccess extends MyOrdersState {
  final MyOrdersModel myOrdersModel;

  const MyOrdersSuccess({required this.myOrdersModel});

  @override
  List<Object> get props => [myOrdersModel];
}

class  MyOrdersFailure extends MyOrdersState {
  final String message;

  const MyOrdersFailure({required this.message});

  @override
  List<Object> get props => [message];
}
