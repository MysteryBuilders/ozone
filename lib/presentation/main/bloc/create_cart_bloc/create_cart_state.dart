part of 'create_cart_bloc.dart';

sealed class CreateCartState extends Equatable {
  const CreateCartState();
}

final class CreateCartInitial extends CreateCartState {
  @override
  List<Object> get props => [];
}
class CreateCartLoading extends CreateCartState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CreateCartSuccess extends CreateCartState {
  final int cartId;

  const CreateCartSuccess({required this.cartId});

  @override
  List<Object> get props => [cartId];
}

class CreateCartFailure extends CreateCartState {
  final String message;

  const CreateCartFailure({required this.message});

  @override
  List<Object> get props => [message];
}