part of 'remove_wish_list_bloc.dart';

sealed class RemoveWishListState extends Equatable {
  const RemoveWishListState();
}

final class RemoveWishListInitial extends RemoveWishListState {
  @override
  List<Object> get props => [];
}

class RemoveWishListLoading extends RemoveWishListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RemoveWishListSuccess extends RemoveWishListState {
  final RemoveWishListModel removeWishListModel;

  const RemoveWishListSuccess({required this.removeWishListModel});

  @override
  List<Object> get props => [removeWishListModel];
}

class RemoveWishListFailure extends RemoveWishListState {
  final String message;

  const RemoveWishListFailure({required this.message});

  @override
  List<Object> get props => [message];
}