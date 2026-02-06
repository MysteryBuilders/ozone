part of 'add_to_cart_bloc.dart';

sealed class AddToCartEvent extends Equatable {
  const AddToCartEvent();
}

class AddToCartFetched extends AddToCartEvent {
  final String authorization;
  Map<String,dynamic> map;


   AddToCartFetched(this.authorization,this.map);

  @override
  List<Object> get props => [Random().nextDouble(),authorization,map];
}