import 'package:json_annotation/json_annotation.dart';
part 'check_stock_response.g.dart';
@JsonSerializable()
class ItemCheckStockResponse{
  @JsonKey(name:"sku" )
  String? sku;
  @JsonKey(name:"source_code" )
  String? sourceCode;
  @JsonKey(name:"quantity" )
  int? quantity;
  @JsonKey(name:"status" )
  int? status;


  ItemCheckStockResponse(this.sku,this.sourceCode,this.quantity,this.status);
  // from json

  factory ItemCheckStockResponse.fromJson(Map<String,dynamic> json) =>_$ItemCheckStockResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$ItemCheckStockResponseToJson(this);

}

@JsonSerializable()
class CheckStockResponse{
  @JsonKey(name:"items" )
  List<ItemCheckStockResponse>? list;
  CheckStockResponse(this.list);
  // from json

  factory CheckStockResponse.fromJson(Map<String,dynamic> json) =>_$CheckStockResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$CheckStockResponseToJson(this);

}