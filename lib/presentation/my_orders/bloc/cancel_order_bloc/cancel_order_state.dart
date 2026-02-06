part of 'cancel_order_bloc.dart';

sealed class CancelOrderState extends Equatable {
  const CancelOrderState();
}

final class CancelOrderInitial extends CancelOrderState {
  @override
  List<Object> get props => [];
}

class CancelOrderLoading extends CancelOrderState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class CancelOrderSuccess extends CancelOrderState {
  final bool success;

  const CancelOrderSuccess({required this.success});

  @override
  List<Object> get props => [success];
}

class CancelOrderFailure extends CancelOrderState {
  final String message;

  const CancelOrderFailure({required this.message});

  @override
  List<Object> get props => [message];
}