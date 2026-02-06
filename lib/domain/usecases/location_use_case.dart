
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/app_version_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/contact_us_model.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/home_screen_model.dart';
import 'package:ozon/domain/model/location_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class LocationUseCase implements BaseUseCase<LocationUseCaseInput,LocationModel>{
  final Repository _repository;
  LocationUseCase(this._repository);

  @override
  Future<Either<Failure, LocationModel>> execute(LocationUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.saveLocation(input.map, input.authorization);
  }


}
class LocationUseCaseInput {
  Map<String,dynamic> map;
  String authorization;


  LocationUseCaseInput(this.map,this.authorization);
}