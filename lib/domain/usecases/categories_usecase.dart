
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/category_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CategoriesUseCase implements BaseUseCase<CategoriesUseCaseInput,CategoryModel>{
  final Repository _repository;
  CategoriesUseCase(this._repository);

  @override
  Future<Either<Failure, CategoryModel>> execute(CategoriesUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.category(input.authorization);
  }


}
class CategoriesUseCaseInput {
  String authorization;


  CategoriesUseCaseInput(this.authorization);
}