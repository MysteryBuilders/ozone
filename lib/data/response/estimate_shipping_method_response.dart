import 'package:json_annotation/json_annotation.dart';

part 'estimate_shipping_method_response.g.dart';

// Root model
@JsonSerializable()
class EstimateShippingMethodResponse {
  @JsonKey(name: 'carrier_code')
  final String carrierCode;

  @JsonKey(name: 'method_code')
  final String methodCode;
  @JsonKey(name: 'carrier_title')
  final String carrierTitle;

  @JsonKey(name: 'method_title')
  final String methodTitle;
  @JsonKey(name: 'amount')
  final double amount;
  @JsonKey(name: 'base_amount')
  final double baseAmount;
  @JsonKey(name: 'available')
  final bool available;
  @JsonKey(name: 'error_message')
  final String errorMessage;
  @JsonKey(name: 'price_excl_tax')
  final double priceExclTax;
  @JsonKey(name: 'price_incl_tax')
  final double priceInclTax;
  EstimateShippingMethodResponse(this.methodTitle, {required this.carrierCode, required this.methodCode, required this.carrierTitle,
  required this.amount,required this.baseAmount,required this.available,required this.errorMessage,required this.priceExclTax,required this.priceInclTax});

  factory EstimateShippingMethodResponse.fromJson(Map<String, dynamic> json) => _$EstimateShippingMethodResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EstimateShippingMethodResponseToJson(this);


}