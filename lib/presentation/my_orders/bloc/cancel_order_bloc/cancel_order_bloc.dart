import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/usecases/cancel_order_use_case.dart';

part 'cancel_order_event.dart';
part 'cancel_order_state.dart';

class CancelOrderBloc extends Bloc<CancelOrderEvent, CancelOrderState> {
  final CancelOrderUseCase cancelOrderUseCase;

  CancelOrderBloc(this.cancelOrderUseCase) : super(CancelOrderInitial()) {
    on<CancelOrderButtonPressed>((event, emit) async {
      emit(CancelOrderLoading());
      (await cancelOrderUseCase.execute(CancelOrderUseCaseInput(event.orderId,event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(CancelOrderFailure(message: failure.message)) ;
        },
            (response) async {




          emit(CancelOrderSuccess(success: response));



        },
      );

    });
  }

}
