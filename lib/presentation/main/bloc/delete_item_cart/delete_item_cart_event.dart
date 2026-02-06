part of 'delete_item_cart_bloc.dart';

sealed class DeleteItemCartEvent extends Equatable {
  const DeleteItemCartEvent();
}

class DeleteItemCartButtonPressed extends DeleteItemCartEvent {
  final int itemId;
  final String authorization;



  const DeleteItemCartButtonPressed({required this.itemId,required this.authorization});

  @override
  List<Object> get props => [itemId,authorization];
}

class DeleteMultipleItemsCartPressed extends DeleteItemCartEvent {
  final List<String> itemIds;
  final String authorization;

  DeleteMultipleItemsCartPressed({required this.itemIds, required this.authorization});

  @override
  // TODO: implement props
  List<Object?> get props => [this.itemIds,this.authorization];
}