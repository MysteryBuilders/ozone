
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/app_version_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/country_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AppVersionsUseCase implements BaseUseCase<AppVersionsUseCaseInput,AppVersionModel>{
  final Repository _repository;
  AppVersionsUseCase(this._repository);

  @override
  Future<Either<Failure, AppVersionModel>> execute(AppVersionsUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.appVersions(input.authorization);
  }


}
class AppVersionsUseCaseInput {
  String authorization;


  AppVersionsUseCaseInput(this.authorization);
}