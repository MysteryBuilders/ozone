
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/order_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CartUseCase implements BaseUseCase<CartUseCaseInput,OrderModel>{
  final Repository _repository;
  CartUseCase(this._repository);

  @override
  Future<Either<Failure, OrderModel>> execute(CartUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.cart(input.authorization);
  }


}
class CartUseCaseInput {
  String authorization;


  CartUseCaseInput(this.authorization);
}