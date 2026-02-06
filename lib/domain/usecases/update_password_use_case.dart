
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class UpdatePasswordUseCase implements BaseUseCase<UpdatePasswordUseCaseInput,bool>{
  final Repository _repository;
  UpdatePasswordUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(UpdatePasswordUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.updatePassword(input.newPassword,input.confirmNewPassowrd,input.currentPassword,input.authorization);
  }


}
class UpdatePasswordUseCaseInput {
  String newPassword;
  String confirmNewPassowrd;

  String currentPassword;
  String authorization;

  UpdatePasswordUseCaseInput(this.newPassword,this.confirmNewPassowrd,this.currentPassword,this.authorization);
}