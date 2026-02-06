
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class DeleteAccountUseCase implements BaseUseCase<DeleteAccountUseCaseInput,bool>{
  final Repository _repository;
  DeleteAccountUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(DeleteAccountUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.deleteAccount(input.userId,input.authorization);
  }


}
class DeleteAccountUseCaseInput {
  int userId;
  String authorization;



  DeleteAccountUseCaseInput(this.userId,this.authorization);
}