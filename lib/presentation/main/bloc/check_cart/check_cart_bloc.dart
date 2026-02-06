import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/model/order_model.dart';
import '../../../../domain/usecases/cart_use_case.dart';

part 'check_cart_event.dart';
part 'check_cart_state.dart';

class CheckCartBloc extends Bloc<CheckCartEvent, CheckCartState> {
  final CartUseCase cartUseCase;

  CheckCartBloc(this.cartUseCase) : super(CheckCartInitial()) {
    print("CartBloc instance created");
    on<CheckCartFetched>((event, emit) async {
      emit(CheckCartLoading());
      (await cartUseCase.execute(CartUseCaseInput(event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(CheckCartFailure(message: failure.message)) ;
        },
            (response) async {




          emit(CheckCartSuccess(orderModel: response));



        },
      );

    });
  }
}
