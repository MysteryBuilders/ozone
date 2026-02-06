part of 'update_cart_bloc.dart';

sealed class UpdateCartState extends Equatable {
  const UpdateCartState();
}

final class UpdateCartInitial extends UpdateCartState {
  @override
  List<Object> get props => [];
}

class UpdateCartLoading extends UpdateCartState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateCartSuccess extends UpdateCartState {
  final AddToCartModel addToCartModel;

  const UpdateCartSuccess({required this.addToCartModel});

  @override
  List<Object> get props => [addToCartModel];
}

class UpdateCartFailure extends UpdateCartState {
  final String message;

  const UpdateCartFailure({required this.message});

  @override
  List<Object> get props => [message];
}

