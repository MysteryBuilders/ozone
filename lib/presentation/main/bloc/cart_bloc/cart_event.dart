part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();
}

class CartFetched extends CartEvent {
  final String authorization;


  const CartFetched(this.authorization);

  @override
  List<Object> get props => [authorization,Random().nextDouble()];
}