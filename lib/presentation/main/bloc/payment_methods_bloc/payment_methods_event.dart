part of 'payment_methods_bloc.dart';

sealed class PaymentMethodsEvent extends Equatable {
  const PaymentMethodsEvent();
}
class PaymentMethodsFetched extends PaymentMethodsEvent {

  final String authorization;


  const PaymentMethodsFetched(this.authorization);

  @override
  List<Object> get props => [Random().nextDouble(),authorization];
}