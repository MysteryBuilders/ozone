
import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/adresses_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/order_model.dart';
import 'package:ozon/domain/model/shipping_information_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ShippingInformationUseCase implements BaseUseCase<ShippingInformationUseCaseInput,ShippingInformationModel>{
  final Repository _repository;
  ShippingInformationUseCase(this._repository);

  @override
  Future<Either<Failure, ShippingInformationModel>> execute(ShippingInformationUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.shippingInformation(input.map,input.authorization);
  }


}
class ShippingInformationUseCaseInput {
  String authorization;
  Map<String,dynamic>map;


  ShippingInformationUseCaseInput(this.map,this.authorization);
}