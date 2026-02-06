import 'package:json_annotation/json_annotation.dart';
part 'payment_method_response.g.dart';
@JsonSerializable()
class PaymentMethodResponse {

  @JsonKey(name:"code" )
  String? code;
  @JsonKey(name:"title" )
  String? title;


  PaymentMethodResponse(this.code,this.title);
  // from json

  factory PaymentMethodResponse.fromJson(Map<String,dynamic> json) =>_$PaymentMethodResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$PaymentMethodResponseToJson(this);

}