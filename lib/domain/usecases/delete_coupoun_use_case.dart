
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class DeleteCoupounUseCase implements BaseUseCase<DeleteCoupounUseCaseInput,bool>{
  final Repository _repository;
  DeleteCoupounUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(DeleteCoupounUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.deleteCouponCode(input.authorization);
  }


}
class DeleteCoupounUseCaseInput {

  String authorization;



  DeleteCoupounUseCaseInput(this.authorization);
}