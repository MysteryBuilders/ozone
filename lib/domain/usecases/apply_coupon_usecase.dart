
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/stock_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ApplyCouponUsecase implements BaseUseCase<ApplyCouponUsecaseInput,bool>{
  final Repository _repository;
  ApplyCouponUsecase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(ApplyCouponUsecaseInput input) async{
    // TODO: implement execute
    return await _repository.applyCoupon(input.coupoun,input.authorization);
  }


}
class ApplyCouponUsecaseInput {
  String coupoun;
  String authorization;


  ApplyCouponUsecaseInput(this.coupoun,this.authorization);
}