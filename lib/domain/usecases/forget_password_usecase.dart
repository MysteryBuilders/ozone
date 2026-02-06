
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ForgetPasswordUseCase implements BaseUseCase<ForgetPasswordUseCaseInput,bool>{
  final Repository _repository;
  ForgetPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(ForgetPasswordUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.forgetPassword(input.email,input.authorization);
  }


}
class ForgetPasswordUseCaseInput {
  String email;
  String authorization;



  ForgetPasswordUseCaseInput(this.email,this.authorization);
}