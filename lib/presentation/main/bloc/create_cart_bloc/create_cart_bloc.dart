import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/usecases/create_cart_use_case.dart';

part 'create_cart_event.dart';
part 'create_cart_state.dart';

class CreateCartBloc extends Bloc<CreateCartEvent, CreateCartState> {
  final CreateCartUseCase createCartUseCase;

  CreateCartBloc(this.createCartUseCase) : super(CreateCartInitial()) {
    on<CreateCartFetched>((event, emit) async {
      emit(CreateCartLoading());
      (await createCartUseCase.execute(CreateCartUseCaseInput(event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(CreateCartFailure(message: failure.message)) ;
        },
            (response) async {




          emit(CreateCartSuccess(cartId: response));



        },
      );

    });
  }

}
