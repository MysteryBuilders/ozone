import 'dart:collection';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/estimate_shipping_method.dart';
import 'package:ozon/domain/usecases/estimate_shipping_method_use_case.dart';

part 'estimate_method_event.dart';
part 'estimate_method_state.dart';

class EstimateMethodBloc extends Bloc<EstimateMethodEvent, EstimateMethodState> {
  final EstimateShippingMethodUseCase estimateShippingMethodUseCase;


  EstimateMethodBloc(this.estimateShippingMethodUseCase) : super(EstimateMethodInitial()) {
    on<EstimateMethodFetched>((event, emit) async {
      emit(EstimateMethodLoading());
      (await estimateShippingMethodUseCase.execute(EstimateShippingMethodUseCaseInput(event.map,event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(EstimateMethodFailure(message: failure.message)) ;
        },
            (response) async {



          emit(EstimateMethodSuccess(estimateMethodList: response));



        },
      );

    });

  }
}
