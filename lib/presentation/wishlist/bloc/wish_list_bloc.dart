import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/wishlist_model.dart';
import 'package:ozon/domain/usecases/wishlist_use_case.dart';

part 'wish_list_event.dart';
part 'wish_list_state.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  final WishlistUseCase wishlistUseCase;

  WishListBloc(this.wishlistUseCase) : super(WishListInitial()) {
    on<WishListFetched>((event, emit) async {
      emit(WishListLoading());
      (await wishlistUseCase.execute(WishlistUseCaseInput(event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(WishListFailure(message: failure.message)) ;
        },
            (response) async {




          emit(WishListSuccess(wishListModel: response));



        },
      );

    });
  }

}
