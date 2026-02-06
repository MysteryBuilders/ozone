
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/estimate_shipping_method.dart';
import 'package:ozon/domain/model/payment_method_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class PaymentMethodsUsecase implements BaseUseCase<PaymentMethodsUsecaseInput,List<PaymentMethodModel>>{
  final Repository _repository;
  PaymentMethodsUsecase(this._repository);

  @override
  Future<Either<Failure, List<PaymentMethodModel>>> execute(PaymentMethodsUsecaseInput input) async{
    // TODO: implement execute
    return await _repository.paymentMethods(input.authorization);
  }


}
class PaymentMethodsUsecaseInput {

  String authorization;



  PaymentMethodsUsecaseInput(this.authorization);
}