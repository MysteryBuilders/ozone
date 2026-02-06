import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/usecases/order_use_case.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderUseCase orderUseCase;

  OrderBloc(this.orderUseCase) : super(OrderInitial()) {
    on<OrderFetched>((event, emit) async {
      emit(OrderLoading());
      (await orderUseCase.execute(OrderUseCaseInput(event.authorization,event.map))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(OrderFailure(message: failure.message)) ;
        },
            (response) async {




          emit(OrderSuccess(orderId: response));



        },
      );

    });
  }
}
