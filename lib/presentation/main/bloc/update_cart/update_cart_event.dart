part of 'update_cart_bloc.dart';

sealed class UpdateCartEvent extends Equatable {
  const UpdateCartEvent();
}

class UpdateCartFetched extends UpdateCartEvent {
  final int itemId;
  final String authorization;
  final Map<String,dynamic> map;


 const UpdateCartFetched(this.itemId,this.authorization,this.map);

  @override
  List<Object> get props => [Random().nextDouble(),authorization,map,itemId];
}