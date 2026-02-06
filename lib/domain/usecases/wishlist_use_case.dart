
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/adresses_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/order_model.dart';
import 'package:ozon/domain/model/wishlist_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class WishlistUseCase implements BaseUseCase<WishlistUseCaseInput,WishListModel>{
  final Repository _repository;
  WishlistUseCase(this._repository);

  @override
  Future<Either<Failure, WishListModel>> execute(WishlistUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.wishList(input.authorization);
  }


}
class WishlistUseCaseInput {
  String authorization;


  WishlistUseCaseInput(this.authorization);
}