import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/add_to_cart_model.dart';
import 'package:ozon/domain/usecases/add_to_cart_use_case.dart';

part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final AddToCartUseCase addToCartUseCase;

  AddToCartBloc(this.addToCartUseCase) : super(AddToCartInitial()) {
    on<AddToCartFetched>((event, emit) async {
      emit(AddToCartLoading());
      (await addToCartUseCase.execute(AddToCartUseCaseInput(event.authorization,event.map))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(AddToCartFailure(message: failure.message)) ;
        },
            (response) async {




          emit(AddToCartSuccess(addToCartModel: response));



        },
      );

    });
  }

}
