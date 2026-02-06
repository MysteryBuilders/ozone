part of 'add_to_cart_bloc.dart';

sealed class AddToCartState extends Equatable {
  const AddToCartState();
}

final class AddToCartInitial extends AddToCartState {
  @override
  List<Object> get props => [];
}

class AddToCartLoading extends AddToCartState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddToCartSuccess extends AddToCartState {
  final AddToCartModel addToCartModel;

  const AddToCartSuccess({required this.addToCartModel});

  @override
  List<Object> get props => [addToCartModel];
}

class AddToCartFailure extends AddToCartState {
  final String message;

  const AddToCartFailure({required this.message});

  @override
  List<Object> get props => [message];
}

