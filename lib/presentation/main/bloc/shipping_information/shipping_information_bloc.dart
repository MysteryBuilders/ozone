import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/shipping_information_model.dart';
import 'package:ozon/domain/usecases/shipping_information_use_case.dart';

part 'shipping_information_event.dart';
part 'shipping_information_state.dart';

class ShippingInformationBloc extends Bloc<ShippingInformationEvent, ShippingInformationState> {
  final ShippingInformationUseCase shippingInformationUseCase;


  ShippingInformationBloc(this.shippingInformationUseCase) : super(ShippingInformationInitial()) {
    on<ShippingInformationFetched>((event, emit) async {
      emit(ShippingInformationLoading());
      (await shippingInformationUseCase.execute(ShippingInformationUseCaseInput(event.map,event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(ShippingInformationFailure(message: failure.message)) ;
        },
            (response) async {



          emit(ShippingInformationSuccess(shippingInformationModel: response));



        },
      );

    });

  }

}
