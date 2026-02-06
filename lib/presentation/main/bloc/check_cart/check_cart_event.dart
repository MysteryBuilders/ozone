part of 'check_cart_bloc.dart';

sealed class CheckCartEvent extends Equatable {
  const CheckCartEvent();
}
class CheckCartFetched extends CheckCartEvent {
  final String authorization;


  const CheckCartFetched(this.authorization);

  @override
  List<Object> get props => [authorization];
}