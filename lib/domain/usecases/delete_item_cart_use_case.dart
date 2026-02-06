
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class DeleteItemCartUseCase implements BaseUseCase<DeleteItemCartUseCaseInput,bool>{
  final Repository _repository;
  DeleteItemCartUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(DeleteItemCartUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.deleteItemCart(input.itemId,input.authorization);
  }


}
class DeleteItemCartUseCaseInput {
  int itemId;
  String authorization;



  DeleteItemCartUseCaseInput(this.itemId,this.authorization);
}