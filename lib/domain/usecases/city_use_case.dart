
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/city_model.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/state_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CityUseCase implements BaseUseCase<CityUseCaseInput,List<CityModel>>{
  final Repository _repository;
  CityUseCase(this._repository);

  @override
  Future<Either<Failure, List<CityModel>>> execute(CityUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.cities(input.stateName);
  }


}
class CityUseCaseInput {
  String stateName;


  CityUseCaseInput(this.stateName);
}