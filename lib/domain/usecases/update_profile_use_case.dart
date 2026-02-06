
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class UpdateProfileUseCase implements BaseUseCase<UpdateProfileUseCaseInput,bool>{
  final Repository _repository;
  UpdateProfileUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(UpdateProfileUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.updateProfile(input.email,input.password,input.authorization);
  }


}
class UpdateProfileUseCaseInput {
  String email;

  String password;
  String authorization;

  UpdateProfileUseCaseInput(this.email,this.password,this.authorization);
}