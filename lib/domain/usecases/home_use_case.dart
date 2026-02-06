
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/app_version_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/contact_us_model.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/home_screen_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class HomeUseCase implements BaseUseCase<HomeUseCaseInput,ScreenHome>{
  final Repository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, ScreenHome>> execute(HomeUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.getHome(input.authorization);
  }


}
class HomeUseCaseInput {
  String authorization;


  HomeUseCaseInput(this.authorization);
}