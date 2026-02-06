part of 'delete_item_cart_bloc.dart';

sealed class DeleteItemCartState extends Equatable {
  const DeleteItemCartState();
}

final class DeleteItemCartInitial extends DeleteItemCartState {
  @override
  List<Object> get props => [];
}

class DeleteItemCartLoading extends DeleteItemCartState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class DeleteItemCartSuccess extends DeleteItemCartState {
  final bool success;

  const DeleteItemCartSuccess({required this.success});

  @override
  List<Object> get props => [success];
}

class DeleteItemCartFailure extends DeleteItemCartState {
  final String message;

  const DeleteItemCartFailure({required this.message});

  @override
  List<Object> get props => [message];
}
