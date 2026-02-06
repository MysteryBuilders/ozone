import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/app/app.dart';

import 'package:ozon/domain/usecases/product_use_case.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';

import '../../../domain/model/products_model.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductUseCase productUseCase;


  ProductsBloc(this.productUseCase) : super(ProductsInitial()) {
    on<ProductsFetched>((event, emit) async {
      emit(ProductsLoading());
      (await productUseCase.execute(ProductUseCaseInput(event.map,event.authorization)))
          .fold(
            (failure) {

          print("failture ---> $failure");
          emit(ProductsFailure(message: AppStrings.noDataFound.tr())) ;
        },
            (response) async {




          emit(ProductsSuccess(productsModel: response));



        },
      );

    });
  }

}
