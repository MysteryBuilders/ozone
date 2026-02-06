
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/adresses_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/order_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AddressUseCase implements BaseUseCase<AddressUseCaseInput,CustomerDomain>{
  final Repository _repository;
  AddressUseCase(this._repository);

  @override
  Future<Either<Failure, CustomerDomain>> execute(AddressUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.addresses(input.authorization);
  }


}
class AddressUseCaseInput {
  String authorization;


  AddressUseCaseInput(this.authorization);
}