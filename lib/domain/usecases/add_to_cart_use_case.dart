
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/add_to_cart_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/order_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AddToCartUseCase implements BaseUseCase<AddToCartUseCaseInput,AddToCartModel>{
  final Repository _repository;
  AddToCartUseCase(this._repository);

  @override
  Future<Either<Failure, AddToCartModel>> execute(AddToCartUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.addToCart(input.map,input.authorization);
  }


}
class AddToCartUseCaseInput {
  String authorization;
  Map<String,dynamic> map;


  AddToCartUseCaseInput(this.authorization,this.map);
}