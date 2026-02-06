
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/app_version_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/contact_us_model.dart';
import 'package:ozon/domain/model/country_model.dart';

import '../../data/network/failure.dart';
import '../model/category_home_model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CategoriesHomeUsecase implements BaseUseCase<CategoriesHomeUsecaseCaseInput,CategoryHomeModel>{
  final Repository _repository;
  CategoriesHomeUsecase(this._repository);

  @override
  Future<Either<Failure, CategoryHomeModel>> execute(CategoriesHomeUsecaseCaseInput input) async{
    // TODO: implement execute
    return await _repository.categoryhome(input.authorization);
  }


}
class CategoriesHomeUsecaseCaseInput {
  String authorization;


  CategoriesHomeUsecaseCaseInput(this.authorization);
}