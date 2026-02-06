import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/store_locator_model.dart';
import 'package:ozon/domain/usecases/store_locator_use_case.dart';

part 'store_locator_event.dart';
part 'store_locator_state.dart';

class StoreLocatorBloc extends Bloc<StoreLocatorEvent, StoreLocatorState> {
  final StoreLocatorUseCase storeLocatorUseCase;


  StoreLocatorBloc(this.storeLocatorUseCase) : super(StoreLocatorInitial()) {
    on<StoreLocatorFetched>((event, emit) async {
      emit(StoreLocatorLoading());
      (await storeLocatorUseCase.execute(StoreLocatorUseCaseInput(event.authorization,event.country,event.state))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(StoreLocatorFailure(message: failure.message)) ;
        },
            (response) async {



          emit(StoreLocatorSuccess(storeLocatorModel: response));



        },
      );

    });

  }

}
