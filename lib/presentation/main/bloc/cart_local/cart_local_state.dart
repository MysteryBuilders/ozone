part of 'cart_local_bloc.dart';

sealed class CartLocalState extends Equatable {
  const CartLocalState();
}

final class CartLocalInitial extends CartLocalState {
  @override
  List<Object> get props => [];
}



class CartLocalLoaded extends CartLocalState {
   final LocalCartModel cart;

  CartLocalLoaded({required this.cart});

  @override
  // TODO: implement props
  List<Object?> get props => [this.cart];
}