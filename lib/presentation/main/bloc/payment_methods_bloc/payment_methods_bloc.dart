import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/payment_method_model.dart';
import 'package:ozon/domain/usecases/payment_methods_usecase.dart';

part 'payment_methods_event.dart';
part 'payment_methods_state.dart';

class PaymentMethodsBloc extends Bloc<PaymentMethodsEvent, PaymentMethodsState> {
  final PaymentMethodsUsecase paymentMethodsUsecase;


  PaymentMethodsBloc(this.paymentMethodsUsecase) : super(PaymentMethodsInitial()) {
    on<PaymentMethodsFetched>((event, emit) async {
      emit(PaymentMethodsLoading());
      (await paymentMethodsUsecase.execute(PaymentMethodsUsecaseInput(event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(PaymentMethodsFailure(message: failure.message)) ;
        },
            (response) async {



          emit(PaymentMethodsSuccess(paymentMethodList: response));



        },
      );

    });

  }

}
