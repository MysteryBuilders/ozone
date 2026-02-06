import 'package:json_annotation/json_annotation.dart';
part 'stock_response.g.dart';
@JsonSerializable()
class StockResponse {

  @JsonKey(name:"item_id" )
  int? itemId;
  @JsonKey(name:"product_id" )
  int? productId;
  @JsonKey(name:"stock_id" )
  int? stockId;
  @JsonKey(name:"is_in_stock" )
  bool? isInStock;
  @JsonKey(name:"min_sale_qty" )
  int? minSaleQty;
  @JsonKey(name:"qty" )
  int? qty;

  StockResponse(this.itemId,this.productId,this.stockId,this.isInStock,
      this.minSaleQty,this.qty);
  // from json

  factory StockResponse.fromJson(Map<String,dynamic> json) =>_$StockResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$StockResponseToJson(this);

}