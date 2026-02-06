import 'package:ozon/app/constants.dart';
import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/response/check_stock_response.dart';
import 'package:ozon/domain/model/check_stock_model.dart';

extension ItemCheckStockResponseMapper on ItemCheckStockResponse?{
  ItemCheckStockModel toDomain(){
    return ItemCheckStockModel( this?.sku.orEmpty()??Constants.empty,
        this?.sourceCode.orEmpty()??Constants.empty,
        this?.quantity.orZero()??Constants.zero,
      this?.status.orZero()??Constants.zero,




    );

  }



}
extension CheckStockResponseMapper on CheckStockResponse?{
  List<ItemCheckStockModel> get list {
    return (this?.list
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<ItemCheckStockModel>()
        .toList();

  }

  CheckStockModel toDomain(){
    return CheckStockModel( list);
  }



}