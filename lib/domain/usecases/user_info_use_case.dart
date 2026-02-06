
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/user_info_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class UserInfoUseCase implements BaseUseCase<UserInfoUseCaseInput,UserInfoModel>{
  final Repository _repository;
  UserInfoUseCase(this._repository);

  @override
  Future<Either<Failure, UserInfoModel>> execute(UserInfoUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.userInfo(input.authorization);
  }


}
class UserInfoUseCaseInput {
  String authorization;


  UserInfoUseCaseInput(this.authorization);
}