
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/app_version_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/splash_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class SplashUseCase implements BaseUseCase<SplashUseCaseInput,SplashModel>{
  final Repository _repository;
  SplashUseCase(this._repository);

  @override
  Future<Either<Failure, SplashModel>> execute(SplashUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.splash();
  }


}
class SplashUseCaseInput {



  SplashUseCaseInput();
}