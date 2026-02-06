
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class DeleteAddressUseCase implements BaseUseCase<DeleteAddressUseCaseInput,bool>{
  final Repository _repository;
  DeleteAddressUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(DeleteAddressUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.deleteAddress(input.itemId,input.authorization);
  }


}
class DeleteAddressUseCaseInput {
  int itemId;
  String authorization;



  DeleteAddressUseCaseInput(this.itemId,this.authorization);
}