
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/app_version_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/contact_us_model.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/home_screen_model.dart';
import 'package:ozon/domain/model/store_locator_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class StoreLocatorUseCase implements BaseUseCase<StoreLocatorUseCaseInput,StoreLocatorModel>{
  final Repository _repository;
  StoreLocatorUseCase(this._repository);

  @override
  Future<Either<Failure, StoreLocatorModel>> execute(StoreLocatorUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.storeLocator(input.authorization,input.country,input.state);
  }


}
class StoreLocatorUseCaseInput {
  String authorization;
  String country;
  String state;


  StoreLocatorUseCaseInput(this.authorization,this.country,this.state);
}