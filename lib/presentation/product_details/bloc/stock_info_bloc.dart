import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ozon/domain/model/check_stock_model.dart';
import 'package:ozon/domain/model/stock_model.dart';
import 'package:ozon/domain/usecases/stock_info_usecase.dart';

part 'stock_info_event.dart';
part 'stock_info_state.dart';

class StockInfoBloc extends Bloc<StockInfoEvent, StockInfoState> {
  StockInfoUseCase stockInfoUseCase;
  StockInfoBloc(this.stockInfoUseCase) : super(StockInfoInitial()) {
    on<StockInfoFetched>((event, emit) async {
      emit(StockInfoLoading());
      (await stockInfoUseCase.execute(StockInfoUseCaseInput(event.sku,event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(StockInfoFailure(message: failure.message)) ;
        },
            (response) async {




          emit(StockInfoSuccess(stockModel: response));



        },
      );

    });
  }

}
