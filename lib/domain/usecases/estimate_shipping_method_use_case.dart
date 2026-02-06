
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/estimate_shipping_method.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class EstimateShippingMethodUseCase implements BaseUseCase<EstimateShippingMethodUseCaseInput,List<EstimateShippingMethod>>{
  final Repository _repository;
  EstimateShippingMethodUseCase(this._repository);

  @override
  Future<Either<Failure, List<EstimateShippingMethod>>> execute(EstimateShippingMethodUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.estimateShippingMethods(input.map,input.authorization);
  }


}
class EstimateShippingMethodUseCaseInput {
  Map<String,dynamic> map;
  String authorization;



  EstimateShippingMethodUseCaseInput(this.map,this.authorization);
}