import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/order_model.dart';
import 'package:ozon/domain/usecases/cart_use_case.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUseCase cartUseCase;

  CartBloc(this.cartUseCase) : super(CartInitial()) {
    print("CartBloc instance created");
    on<CartFetched>((event, emit) async {
      emit(CartLoading());
      (await cartUseCase.execute(CartUseCaseInput(event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(CartFailure(message: failure.message)) ;
        },
            (response) async {




          emit(CartSuccess(orderModel: response));



        },
      );

    });
  }

}
