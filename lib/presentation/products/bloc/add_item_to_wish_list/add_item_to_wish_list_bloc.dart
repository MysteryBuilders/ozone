import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/add_item_to_wishlist_model.dart';
import 'package:ozon/domain/usecases/add_item_to_wish_list_usecase.dart';

part 'add_item_to_wish_list_event.dart';
part 'add_item_to_wish_list_state.dart';

class AddItemToWishListBloc extends Bloc<AddItemToWishListEvent, AddItemToWishListState> {
  final AddItemToWishListUsecase addItemToWishListUsecase;

  AddItemToWishListBloc(this.addItemToWishListUsecase) : super(AddItemToWishListInitial()) {
    on<AddItemToWishListFetched>((event, emit) async {
      emit(AddItemToWishListLoading());
      (await addItemToWishListUsecase.execute(AddItemToWishListUsecaseInput(event.authorization,event.id))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(AddItemToWishListFailure(message: failure.message)) ;
        },
            (response) async {




          emit(AddItemToWishListSuccess(addItemToWishListModel: response));



        },
      );

    });
  }

}
