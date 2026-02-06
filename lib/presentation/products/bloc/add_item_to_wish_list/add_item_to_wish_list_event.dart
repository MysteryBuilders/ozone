part of 'add_item_to_wish_list_bloc.dart';

sealed class AddItemToWishListEvent extends Equatable {
  const AddItemToWishListEvent();
}

class AddItemToWishListFetched extends AddItemToWishListEvent {
  final String authorization;
  final String id;


  const AddItemToWishListFetched(this.authorization,this.id);

  @override
  List<Object> get props => [Random().nextDouble(),id,authorization];
}