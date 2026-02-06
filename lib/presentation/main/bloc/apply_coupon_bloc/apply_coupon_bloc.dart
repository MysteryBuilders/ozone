import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/usecases/apply_coupon_usecase.dart';

part 'apply_coupon_event.dart';
part 'apply_coupon_state.dart';

class ApplyCouponBloc extends Bloc<ApplyCouponEvent, ApplyCouponState> {
  ApplyCouponUsecase applyCouponUsecase;
  ApplyCouponBloc(this.applyCouponUsecase) : super(ApplyCouponInitial()) {
    on<ApplyCouponFetched>((event, emit) async {
      emit(ApplyCouponLoading());
      (await applyCouponUsecase.execute(ApplyCouponUsecaseInput(event.coupoun,event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(ApplyCouponFailure(message: failure.message)) ;
        },
            (response) async {




          emit(ApplyCouponSuccess(isSuccess: response));



        },
      );

    });
  }

}
