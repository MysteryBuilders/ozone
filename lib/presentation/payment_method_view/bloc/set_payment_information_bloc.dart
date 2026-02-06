import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/usecases/set_payment_information_use_case.dart';

part 'set_payment_information_event.dart';
part 'set_payment_information_state.dart';

class SetPaymentInformationBloc extends Bloc<SetPaymentInformationEvent, SetPaymentInformationState> {
  final SetPaymentInformationUseCase setPaymentInformationUseCase;

  SetPaymentInformationBloc(this.setPaymentInformationUseCase) : super(SetPaymentInformationInitial()) {
    on<setPaymentInformationFetched>((event, emit) async {
      emit(SetPaymentInformationLoading(index: event.index));
      (await setPaymentInformationUseCase.execute(SetPaymentInformationUseCaseInput(event.authorization,event.map))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(SetPaymentInformationFailure(message: failure.message,index: event.index)) ;
        },
            (response) async {




          emit(SetPaymentInformationSuccess(code: response,index: event.index));



        },
      );

    });
  }

}
