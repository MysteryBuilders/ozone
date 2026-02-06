import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/brands_model.dart';
import 'package:ozon/domain/usecases/brands_use_case.dart';

part 'brands_event.dart';
part 'brands_state.dart';

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  final BrandsUseCase brandsUseCase;


  BrandsBloc(this.brandsUseCase) : super(BrandsInitial()) {
    on<BrandsFetched>((event, emit) async {
      emit(BrandsStateLoading());
      (await brandsUseCase.execute(BrandsUseCaseInput(event.authorization))).fold(
            (failure) {

          print("failure ---> code: ${failure.code}, message: ${failure.message}");
          emit(BrandsStateFailure(message: failure.message)) ;
        },
            (response) async {




          emit(BrandsStateSuccess(brandsList: response));



        },
      );

    });

  }

}
