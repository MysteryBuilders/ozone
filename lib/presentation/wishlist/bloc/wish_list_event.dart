part of 'wish_list_bloc.dart';

sealed class WishListEvent extends Equatable {
  const WishListEvent();
}

class WishListFetched extends WishListEvent {
  final String authorization;


  const WishListFetched(this.authorization);

  @override
  List<Object> get props => [Random().nextDouble(),authorization];
}