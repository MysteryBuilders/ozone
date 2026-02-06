
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/brands_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/city_model.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/state_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class BrandsUseCase implements BaseUseCase<BrandsUseCaseInput,List<BrandsDataModel>>{
  final Repository _repository;
  BrandsUseCase(this._repository);

  @override
  Future<Either<Failure, List<BrandsDataModel>>> execute(BrandsUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.getBrands(input.Authorization);
  }


}
class BrandsUseCaseInput {
  String Authorization;


  BrandsUseCaseInput(this.Authorization);
}