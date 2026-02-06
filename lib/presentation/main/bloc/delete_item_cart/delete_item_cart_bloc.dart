import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/usecases/delete_item_cart_use_case.dart';

part 'delete_item_cart_event.dart';
part 'delete_item_cart_state.dart';

class DeleteItemCartBloc extends Bloc<DeleteItemCartEvent, DeleteItemCartState> {
  final DeleteItemCartUseCase deleteItemCartUseCase;

  DeleteItemCartBloc(this.deleteItemCartUseCase) : super(DeleteItemCartInitial()) {
    on<DeleteItemCartButtonPressed>((event, emit) async {
      emit(DeleteItemCartLoading());
      (await deleteItemCartUseCase.execute(DeleteItemCartUseCaseInput(event.itemId,event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(DeleteItemCartFailure(message: failure.message)) ;
        },
            (response) async {




          emit(DeleteItemCartSuccess(success: response));



        },
      );

    });
    on<DeleteMultipleItemsCartPressed>((event, emit) async {
      emit(DeleteItemCartLoading());

      for (final itemId in event.itemIds) {
        final result = await deleteItemCartUseCase.execute(
          DeleteItemCartUseCaseInput(int.parse(itemId), event.authorization),
        );

        result.fold(
              (failure) {
            emit(DeleteItemCartFailure(message: "Failed to delete item $itemId: ${failure.message}"));
            return;
          },
              (_) {},
        );
      }

      emit(DeleteItemCartSuccess(success: true));
    });
  }
}
