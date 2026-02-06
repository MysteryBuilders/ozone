
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/brands_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/city_model.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/sorting_category_model.dart';
import 'package:ozon/domain/model/state_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class SortCategoryUseCase implements BaseUseCase<SortCategoryUseCaseInput,SortingCategoryModel>{
  final Repository _repository;
  SortCategoryUseCase(this._repository);

  @override
  Future<Either<Failure, SortingCategoryModel>> execute(SortCategoryUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.sortingCategory(input.Authorization,input.categoryId);
  }


}
class SortCategoryUseCaseInput {
  String Authorization;
  int categoryId;


  SortCategoryUseCaseInput(this.Authorization,this.categoryId);
}