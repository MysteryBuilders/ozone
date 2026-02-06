
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/add_to_cart_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/order_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class OrderUseCase implements BaseUseCase<OrderUseCaseInput,int>{
  final Repository _repository;
  OrderUseCase(this._repository);

  @override
  Future<Either<Failure, int>> execute(OrderUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.order(input.map,input.authorization);
  }


}
class OrderUseCaseInput {
  String authorization;
  Map<String,dynamic> map;


  OrderUseCaseInput(this.authorization,this.map);
}