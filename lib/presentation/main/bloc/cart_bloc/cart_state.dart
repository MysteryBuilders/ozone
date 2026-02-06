part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();
}

final class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CartSuccess extends CartState {
  final OrderModel orderModel;

  const CartSuccess({required this.orderModel});

  @override
  List<Object> get props => [orderModel];
}

class CartFailure extends CartState {
  final String message;

  const CartFailure({required this.message});

  @override
  List<Object> get props => [message];
}
