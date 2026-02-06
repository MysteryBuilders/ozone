
import 'package:dartz/dartz.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/check_stock_model.dart';
import 'package:ozon/domain/model/stock_model.dart';

import '../../app/app_prefrences.dart';
import '../../data/network/failure.dart';
import '../../data/network/helper_query.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class StockInfoUseCase implements BaseUseCase<StockInfoUseCaseInput,CheckStockModel>{
  final Repository _repository;
  final AppPreferences _appPreferences;
  StockInfoUseCase(this._repository,this._appPreferences);

  @override
  Future<Either<Failure, CheckStockModel>> execute(StockInfoUseCaseInput input) async{
    HelperQuery helperQuery = HelperQuery();
    AppPreferences appPreferences = instance<AppPreferences>();
    String sourceCode =await appPreferences.getSourceCode();
    Map<String,dynamic> map = helperQuery.buildStockParams(sourceCode: sourceCode,sku: input.sku);
    // TODO: implement execute
    return await _repository.checkStock(map,input.authorization);
  }


}
class StockInfoUseCaseInput {
  String sku;
  String authorization;


  StockInfoUseCaseInput(this.sku,this.authorization);
}