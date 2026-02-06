import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/category_home_model.dart';
import 'package:ozon/domain/usecases/categories_home_usecase.dart';

part 'categories_home_event.dart';
part 'categories_home_state.dart';

class CategoriesHomeBloc extends Bloc<CategoriesHomeEvent, CategoriesHomeState> {
  final CategoriesHomeUsecase categoriesHomeUsecase;

  CategoriesHomeBloc(this.categoriesHomeUsecase) : super(CategoriesHomeInitial()) {
    on<CategoriesHomeFetched>((event, emit) async {
      emit(CategoriesHomeLoading());
      (await categoriesHomeUsecase.execute(CategoriesHomeUsecaseCaseInput(event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(CategoriesHomeFailure(message: failure.message)) ;
        },
            (response) async {




          emit(CategoriesHomeSuccess(categoryHomeModel: response));



        },
      );

    });
  }

}
