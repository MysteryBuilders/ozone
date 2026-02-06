
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/adresses_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/order_model.dart';
import 'package:ozon/domain/model/remove_wishlist_model.dart';
import 'package:ozon/domain/model/wishlist_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RemoveWishListUseCase implements BaseUseCase<RemoveWishListUseCaseInput,RemoveWishListModel>{
  final Repository _repository;
  RemoveWishListUseCase(this._repository);

  @override
  Future<Either<Failure, RemoveWishListModel>> execute(RemoveWishListUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.removeWishItemList(input.authorization,input.id);
  }


}
class RemoveWishListUseCaseInput {
  String authorization;
  String id;


  RemoveWishListUseCaseInput(this.authorization,this.id);
}