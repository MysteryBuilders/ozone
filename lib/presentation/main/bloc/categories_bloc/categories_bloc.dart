import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ozon/domain/model/register_model.dart';
import 'package:ozon/domain/usecases/categories_usecase.dart';
import 'package:ozon/domain/usecases/register_usecase.dart';
import 'package:ozon/presentation/main/bloc/categories_bloc/categories_event.dart';
import 'package:ozon/presentation/main/bloc/categories_bloc/categories_state.dart';
import 'package:ozon/presentation/register/bloc/register_event.dart';
import 'package:ozon/presentation/register/bloc/register_state.dart';



class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesUseCase categoriesUseCase;

  CategoriesBloc(this.categoriesUseCase) : super(CategoriesInitial()) {
    on<CategoriesFetched>((event, emit) async {
      emit(CategoriesLoading());
      (await categoriesUseCase.execute(CategoriesUseCaseInput(event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(CategoriesFailure(message: failure.message)) ;
        },
            (response) async {




          emit(CategoriesSuccess(categoryModel: response));



        },
      );

    });
  }
}
