part of 'payment_methods_bloc.dart';

sealed class PaymentMethodsState extends Equatable {
  const PaymentMethodsState();
}

final class PaymentMethodsInitial extends PaymentMethodsState {
  @override
  List<Object> get props => [];
}


class PaymentMethodsLoading extends PaymentMethodsState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class PaymentMethodsSuccess extends PaymentMethodsState {
  final List<PaymentMethodModel> paymentMethodList;

  const PaymentMethodsSuccess({required this.paymentMethodList});

  @override
  List<Object> get props => [paymentMethodList];
}

class PaymentMethodsFailure extends PaymentMethodsState {
  final String message;

  const PaymentMethodsFailure({required this.message});

  @override
  List<Object> get props => [message];
}