
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/check_out_model.dart';
import 'package:ozon/domain/model/order_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CheckOutUseCase implements BaseUseCase<CheckOutUseCaseInput,CheckOutModel>{
  final Repository _repository;
  CheckOutUseCase(this._repository);

  @override
  Future<Either<Failure, CheckOutModel>> execute(CheckOutUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.checkout(input.authorization);
  }


}
class CheckOutUseCaseInput {
  String authorization;


  CheckOutUseCaseInput(this.authorization);
}