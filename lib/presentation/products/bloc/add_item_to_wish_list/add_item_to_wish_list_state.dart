part of 'add_item_to_wish_list_bloc.dart';

sealed class AddItemToWishListState extends Equatable {
  const AddItemToWishListState();
}

final class AddItemToWishListInitial extends AddItemToWishListState {
  @override
  List<Object> get props => [];
}

class AddItemToWishListLoading extends AddItemToWishListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddItemToWishListSuccess extends AddItemToWishListState {
  final AddItemToWishListModel addItemToWishListModel;

  const AddItemToWishListSuccess({required this.addItemToWishListModel});

  @override
  List<Object> get props => [addItemToWishListModel];
}

class AddItemToWishListFailure extends AddItemToWishListState {
  final String message;

  const AddItemToWishListFailure({required this.message});

  @override
  List<Object> get props => [message];
}