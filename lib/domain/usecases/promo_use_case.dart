
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/app_version_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/contact_us_model.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/home_screen_model.dart';
import 'package:ozon/domain/model/promo_model.dart';
import 'package:ozon/domain/model/store_locator_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class PromoUseCase implements BaseUseCase<PromoUseCaseInput,PromoModel>{
  final Repository _repository;
  PromoUseCase(this._repository);

  @override
  Future<Either<Failure, PromoModel>> execute(PromoUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.promo(input.authorization);
  }


}
class PromoUseCaseInput {
  String authorization;



  PromoUseCaseInput(this.authorization);
}