class ItemCheckStockModel{

  String? sku;

  String? sourceCode;

  int? quantity;

  int? status;


  ItemCheckStockModel(this.sku,this.sourceCode,this.quantity,this.status);


}

class CheckStockModel{
  List<ItemCheckStockModel> list;
  CheckStockModel(this.list);
}