
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/my_orders_model.dart';
import 'package:ozon/domain/model/product_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class MyOrdersUseCase implements BaseUseCase<MyOrdersUseCaseInput,MyOrdersModel>{
  final Repository _repository;
  MyOrdersUseCase(this._repository);

  @override
  Future<Either<Failure, MyOrdersModel>> execute(MyOrdersUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.getMyOrders(input.map,input.authorization);
  }


}
class MyOrdersUseCaseInput {
  Map<String,dynamic> map;
  String authorization;


  MyOrdersUseCaseInput(this.map,this.authorization);
}