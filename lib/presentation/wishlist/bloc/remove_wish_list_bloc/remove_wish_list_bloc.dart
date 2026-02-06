import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/remove_wishlist_model.dart';
import 'package:ozon/domain/usecases/remove_wish_list_use_case.dart';

part 'remove_wish_list_event.dart';
part 'remove_wish_list_state.dart';

class RemoveWishListBloc extends Bloc<RemoveWishListEvent, RemoveWishListState> {
  final RemoveWishListUseCase removeWishListUseCase;

  RemoveWishListBloc(this.removeWishListUseCase) : super(RemoveWishListInitial()) {
    on<RemoveWishListFetched>((event, emit) async {
      emit(RemoveWishListLoading());
      (await removeWishListUseCase.execute(RemoveWishListUseCaseInput(event.authorization,event.id))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(RemoveWishListFailure(message: failure.message)) ;
        },
            (response) async {




          emit(RemoveWishListSuccess(removeWishListModel: response));



        },
      );

    });
  }

}
