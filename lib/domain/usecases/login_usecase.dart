
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/new_login_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginCaseInput,NewLoginModel>{
  final Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, NewLoginModel>> execute(LoginCaseInput input) async{
    Map<String,dynamic> map = {};
    map['emailmobile'] = input.email;
    map['password'] = input.password;
    // TODO: implement execute
    return await _repository.newLogin(map,input.authorization);
  }


}
class LoginCaseInput {
  String email;

  String password;
  String authorization;

  LoginCaseInput(this.email,this.password,this.authorization);
}