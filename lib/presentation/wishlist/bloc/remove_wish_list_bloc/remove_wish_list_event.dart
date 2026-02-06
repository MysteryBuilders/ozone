part of 'remove_wish_list_bloc.dart';

sealed class RemoveWishListEvent extends Equatable {
  const RemoveWishListEvent();
}
class RemoveWishListFetched extends RemoveWishListEvent {
  final String authorization;
  final String id;


  const RemoveWishListFetched(this.authorization,this.id);

  @override
  List<Object> get props => [Random().nextDouble(),id,authorization];
}