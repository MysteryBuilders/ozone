
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/add_to_cart_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/order_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class UpdateCartUseCase implements BaseUseCase<UpdateCartUseCaseInput,AddToCartModel>{
  final Repository _repository;
  UpdateCartUseCase(this._repository);

  @override
  Future<Either<Failure, AddToCartModel>> execute(UpdateCartUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.updateCart(input.itemId,input.map,input.authorization);
  }


}
class UpdateCartUseCaseInput {
  int itemId;
  String authorization;
  Map<String,dynamic> map;


  UpdateCartUseCaseInput(this.itemId,this.authorization,this.map);
}