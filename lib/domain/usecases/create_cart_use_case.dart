
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/order_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CreateCartUseCase implements BaseUseCase<CreateCartUseCaseInput,int>{
  final Repository _repository;
  CreateCartUseCase(this._repository);

  @override
  Future<Either<Failure, int>> execute(CreateCartUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.createCart(input.authorization);
  }


}
class CreateCartUseCaseInput {
  String authorization;


  CreateCartUseCaseInput(this.authorization);
}