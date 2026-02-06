// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_information_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingInformationResponse _$ShippingInformationResponseFromJson(
        Map<String, dynamic> json) =>
    ShippingInformationResponse(
      paymentMethods: (json['payment_methods'] as List<dynamic>)
          .map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
      checkOutResponse:
          CheckOutResponse.fromJson(json['totals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShippingInformationResponseToJson(
        ShippingInformationResponse instance) =>
    <String, dynamic>{
      'payment_methods': instance.paymentMethods,
      'totals': instance.checkOutResponse,
    };

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) =>
    PaymentMethod(
      code: json['code'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$PaymentMethodToJson(PaymentMethod instance) =>
    <String, dynamic>{
      'code': instance.code,
      'title': instance.title,
    };
