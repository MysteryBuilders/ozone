
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/brands_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/city_model.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/rating_model.dart';
import 'package:ozon/domain/model/state_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RatingUsecase implements BaseUseCase<RatingUsecaseInput,RatingModel>{
  final Repository _repository;
  RatingUsecase(this._repository);

  @override
  Future<Either<Failure, RatingModel>> execute(RatingUsecaseInput input) async{
    // TODO: implement execute
    return await _repository.rating(input.Authorization,input.body);
  }


}
class RatingUsecaseInput {
  String Authorization;
  Map<String, dynamic> body;


  RatingUsecaseInput(this.Authorization,this.body);
}