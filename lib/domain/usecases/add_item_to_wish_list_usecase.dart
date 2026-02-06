
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/add_item_to_wishlist_model.dart';
import 'package:ozon/domain/model/adresses_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/order_model.dart';
import 'package:ozon/domain/model/remove_wishlist_model.dart';
import 'package:ozon/domain/model/wishlist_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AddItemToWishListUsecase implements BaseUseCase<AddItemToWishListUsecaseInput,AddItemToWishListModel>{
  final Repository _repository;
  AddItemToWishListUsecase(this._repository);

  @override
  Future<Either<Failure, AddItemToWishListModel>> execute(AddItemToWishListUsecaseInput input) async{
    // TODO: implement execute
    return await _repository.addItemToWishItemList(input.authorization,input.id);
  }


}
class AddItemToWishListUsecaseInput {
  String authorization;
  String id;


  AddItemToWishListUsecaseInput(this.authorization,this.id);
}