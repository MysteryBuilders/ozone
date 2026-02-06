import 'package:json_annotation/json_annotation.dart';
part 'state_locator_response.g.dart';
@JsonSerializable()
class StareLocatorResponse{

  @JsonKey(name:"store_code" )
  String? storeCode;
  @JsonKey(name:"website_id" )
  int? webSiteId;
  @JsonKey(name:"source_code" )
  String? sourceCode;


  StareLocatorResponse(this.storeCode,this.webSiteId,this.sourceCode);
  // from json

  factory StareLocatorResponse.fromJson(Map<String,dynamic> json) =>_$StareLocatorResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$StareLocatorResponseToJson(this);

}