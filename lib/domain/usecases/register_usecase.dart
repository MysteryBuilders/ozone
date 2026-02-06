
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/register_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput,RegisterModel>{
  final Repository _repository;
  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, RegisterModel>> execute(RegisterUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.register(input.email,input.firstName,input.lastName,input.password,input.authorization,input.phoneNumber,input.countryCode,input.stateId,input.storeCode);
  }


}
class RegisterUseCaseInput {
  String email;
  String firstName;
  String lastName;

  String password;
  String authorization;
  String phoneNumber;
  String countryCode;
  String stateId;
  String storeCode;

  RegisterUseCaseInput(this.email,this.firstName,this.lastName,this.password,this.authorization,this.phoneNumber,this.countryCode,this.stateId,this.storeCode);
}