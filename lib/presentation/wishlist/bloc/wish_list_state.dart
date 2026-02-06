part of 'wish_list_bloc.dart';

sealed class WishListState extends Equatable {
  const WishListState();
}

final class WishListInitial extends WishListState {
  @override
  List<Object> get props => [];
}
class WishListLoading extends WishListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WishListSuccess extends WishListState {
  final WishListModel wishListModel;

  const WishListSuccess({required this.wishListModel});

  @override
  List<Object> get props => [wishListModel];
}

class WishListFailure extends WishListState {
  final String message;

  const WishListFailure({required this.message});

  @override
  List<Object> get props => [message];
}

