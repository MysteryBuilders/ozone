part of 'check_cart_bloc.dart';

sealed class CheckCartState extends Equatable {
  const CheckCartState();
}

final class CheckCartInitial extends CheckCartState {
  @override
  List<Object> get props => [];
}
class CheckCartLoading extends CheckCartState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CheckCartSuccess extends CheckCartState {
  final OrderModel orderModel;

  const CheckCartSuccess({required this.orderModel});

  @override
  List<Object> get props => [orderModel];
}

class CheckCartFailure extends CheckCartState {
  final String message;

  const CheckCartFailure({required this.message});

  @override
  List<Object> get props => [message];
}
