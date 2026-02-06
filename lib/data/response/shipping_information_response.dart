import 'package:json_annotation/json_annotation.dart';
import 'package:ozon/data/response/check_out_response.dart';

part 'shipping_information_response.g.dart';





@JsonSerializable()
class ShippingInformationResponse {
  @JsonKey(name:"payment_methods" )
  final List<PaymentMethod> paymentMethods;
  @JsonKey(name:"totals" )
  final CheckOutResponse checkOutResponse;


  ShippingInformationResponse({required this.paymentMethods,required this.checkOutResponse});

  factory ShippingInformationResponse.fromJson(Map<String, dynamic> json) => _$ShippingInformationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingInformationResponseToJson(this);
}

@JsonSerializable()
class PaymentMethod {
  @JsonKey(name:"code" )
  final String code;
  @JsonKey(name:"title" )
  final String title;

  PaymentMethod({required this.code, required this.title});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}

