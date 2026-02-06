import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/sorting_category_model.dart';
import 'package:ozon/domain/usecases/sort_category_use_case.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';

part 'sort_category_event.dart';
part 'sort_category_state.dart';

class SortCategoryBloc extends Bloc<SortCategoryEvent, SortCategoryState> {
  final SortCategoryUseCase sortCategoryUseCase;
  SortingCategoryModel? sortingCategoryModel;
  SortingOptionModel? sortingOptionModel;
  String? sortBy;
  int? position;
  Map<String,dynamic> filterMap ={};


  SortCategoryBloc(this.sortCategoryUseCase) : super(SortCategoryInitial()) {
    on<SortCategoryFetched>((event, emit) async {
      emit(SortCategoryLoading());
      (await sortCategoryUseCase.execute(
          SortCategoryUseCaseInput(event.authorization, event.categoryId)))
          .fold(
            (failure) {
          print("failture ---> $failure");
          emit(SortCategoryFailure(message: failure.message));
        },
            (response) async {
          sortingCategoryModel = response;
          sortingOptionModel = SortingOptionModel(AppStrings.arrang.tr(), "");
          position = -1;
          sortBy="DESC";

          for(int i =0;i<response.availableFilterList!.length;i++){
            if(response.availableFilterList![i].filterCode == "price"){

              filterMap['startPrice']=response.availableFilterList![i].minPrice;
              filterMap['endPrice']=response.availableFilterList![i].maxPrice;

            }
          }



          emit(SortCategorySuccess(sortingCategoryModel: response,
              sortingOptionModel: sortingOptionModel!,position: position!,sortBy: sortBy!,filterMap: filterMap));
        },
      );
    });
    on<SortCategorySelect>((event, emit) {
      sortingOptionModel = event.sortingOptionModel;
      position= event.position;
      emit(SortCategorySuccess(sortingCategoryModel: sortingCategoryModel!,
          sortingOptionModel: event.sortingOptionModel,position: position!,sortBy: sortBy!,filterMap: filterMap));

    });
    on<SortBySelect>((event, emit) {
      emit(SortCategorySuccess(sortingCategoryModel: sortingCategoryModel!,
          sortingOptionModel:sortingOptionModel!,position: position!,sortBy: event.sortBy,filterMap: filterMap));

    });

    on<filterFetch>((event, emit) {
      filterMap = event.filterMap;
      emit(SortCategorySuccess(sortingCategoryModel: sortingCategoryModel!,
          sortingOptionModel:sortingOptionModel!,position: position!,sortBy: sortBy!,filterMap: filterMap));

    });
  }
}
