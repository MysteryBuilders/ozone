import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/usecases/update_cart_use_case.dart';

import '../../../../domain/model/add_to_cart_model.dart';

part 'update_cart_event.dart';
part 'update_cart_state.dart';

class UpdateCartBloc extends Bloc<UpdateCartEvent, UpdateCartState> {
  final UpdateCartUseCase updateCartUseCase;

  UpdateCartBloc(this.updateCartUseCase) : super(UpdateCartInitial()) {
    on<UpdateCartFetched>((event, emit) async {
      emit(UpdateCartLoading());
      (await updateCartUseCase.execute(UpdateCartUseCaseInput(event.itemId,event.authorization,event.map))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(UpdateCartFailure(message: failure.message)) ;
        },
            (response) async {




          emit(UpdateCartSuccess(addToCartModel: response));



        },
      );

    });
  }

}
