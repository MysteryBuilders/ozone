part of 'cart_local_bloc.dart';

sealed class CartLocalEvent extends Equatable {
  const CartLocalEvent();
}

class AddCartLocalItem extends CartLocalEvent {
  final OrderItemModel orderItemModel;

  AddCartLocalItem(this.orderItemModel);

  @override
  // TODO: implement props
  List<Object?> get props => [this.orderItemModel];
}
class AddCartLocalListItems extends CartLocalEvent {
  final List<OrderItemModel> orderList;

  AddCartLocalListItems(this.orderList);

  @override
  // TODO: implement props
  List<Object?> get props => [this.orderList];
}

class RemoveCartLocalItem extends CartLocalEvent {
  final OrderItemModel orderItemModel;

  RemoveCartLocalItem(this.orderItemModel);

  @override
  // TODO: implement props
  List<Object?> get props => [this.orderItemModel];
}

class RemoveCartLocal extends CartLocalEvent {




  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class DecreaseCartLocalItem extends CartLocalEvent {
  final OrderItemModel orderItemModel;

  DecreaseCartLocalItem(this.orderItemModel);

  @override
  // TODO: implement props
  List<Object?> get props => [this.orderItemModel];
}