part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();
}

final class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderLoading extends OrderState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OrderSuccess extends OrderState {
  final int orderId;

  const OrderSuccess({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

class OrderFailure extends OrderState {
  final String message;

  const OrderFailure({required this.message});

  @override
  List<Object> get props => [message];
}