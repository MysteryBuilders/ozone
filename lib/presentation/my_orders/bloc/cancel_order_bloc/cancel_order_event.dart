part of 'cancel_order_bloc.dart';

sealed class CancelOrderEvent extends Equatable {
  const CancelOrderEvent();
}
class CancelOrderButtonPressed extends CancelOrderEvent {
  final String orderId;
  final String authorization;



  const CancelOrderButtonPressed({required this.orderId,required this.authorization});

  @override
  List<Object> get props => [orderId,authorization];
}