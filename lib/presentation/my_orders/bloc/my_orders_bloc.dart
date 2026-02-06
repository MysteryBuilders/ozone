import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/my_orders_model.dart';
import 'package:ozon/domain/usecases/my_orders_use_case.dart';

part 'my_orders_event.dart';
part 'my_orders_state.dart';

class MyOrdersBloc extends Bloc<MyOrdersEvent, MyOrdersState> {
  final MyOrdersUseCase myOrdersUseCase;

  MyOrdersBloc(this.myOrdersUseCase) : super(MyOrdersInitial())
  {
    on<MyOrdersFetched>((event, emit) async {
      emit(MyOrdersLoading());
      (await myOrdersUseCase.execute(MyOrdersUseCaseInput(event.map,event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(MyOrdersFailure(message: failure.message)) ;
        },
            (response) async {




          emit(MyOrdersSuccess(myOrdersModel: response));



        },
      );

    });
  }
}
