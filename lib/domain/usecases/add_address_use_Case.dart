
import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/adresses_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/order_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AddAddressUseCase implements BaseUseCase<AddAddressUseCaseInput,CustomerDomain>{
  final Repository _repository;
  AddAddressUseCase(this._repository);

  @override
  Future<Either<Failure, CustomerDomain>> execute(AddAddressUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.addAddress(input.map,input.authorization);
  }


}
class AddAddressUseCaseInput {
  String authorization;
  Map<String,dynamic>map;


  AddAddressUseCaseInput(this.map,this.authorization);
}