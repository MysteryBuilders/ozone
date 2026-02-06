import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/promo_model.dart';
import 'package:ozon/domain/usecases/promo_use_case.dart';

part 'promo_event.dart';
part 'promo_state.dart';

class PromoBloc extends Bloc<PromoEvent, PromoState> {
  final PromoUseCase promoUseCase;


  PromoBloc(this.promoUseCase) : super(PromoInitial()) {
    on<PromoFetched>((event, emit) async {
      emit(PromoLoading());
      (await promoUseCase.execute(PromoUseCaseInput(event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(PromoFailure(message: failure.message)) ;
        },
            (response) async {



          emit(PromoSuccess(promoModel: response));



        },
      );

    });

  }

}
