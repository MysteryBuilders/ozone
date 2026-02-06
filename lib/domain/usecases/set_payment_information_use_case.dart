
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/add_to_cart_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/order_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class SetPaymentInformationUseCase implements BaseUseCase<SetPaymentInformationUseCaseInput,bool>{
  final Repository _repository;
  SetPaymentInformationUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(SetPaymentInformationUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.paymentInformation(input.map,input.authorization);
  }


}
class SetPaymentInformationUseCaseInput {
  String authorization;
  Map<String,dynamic> map;


  SetPaymentInformationUseCaseInput(this.authorization,this.map);
}