
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/category_model.dart';


import '../../data/network/failure.dart';
import '../model/products_model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ProductUseCase implements BaseUseCase<ProductUseCaseInput,ProductsModel>{
  final Repository _repository;
  ProductUseCase(this._repository);

  @override
  Future<Either<Failure, ProductsModel>> execute(ProductUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.getProductsByCategory(input.map,input.authorization);
  }


}
class ProductUseCaseInput {
  Map<String,dynamic> map;
  String authorization;


  ProductUseCaseInput(this.map,this.authorization);
}