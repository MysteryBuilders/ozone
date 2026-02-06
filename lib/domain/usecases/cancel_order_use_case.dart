
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CancelOrderUseCase implements BaseUseCase<CancelOrderUseCaseInput,bool>{
  final Repository _repository;
  CancelOrderUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(CancelOrderUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.cancelOrder(input.orderId,input.authorization);
  }


}
class CancelOrderUseCaseInput {
  String orderId;
  String authorization;



  CancelOrderUseCaseInput(this.orderId,this.authorization);
}