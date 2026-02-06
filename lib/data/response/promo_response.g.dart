// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoResponse _$PromoResponseFromJson(Map<String, dynamic> json) =>
    PromoResponse(
      whatsAppNumber: json['whats_app_number'] as String,
      promoText: json['promo_text'] as String,
    );

Map<String, dynamic> _$PromoResponseToJson(PromoResponse instance) =>
    <String, dynamic>{
      'whats_app_number': instance.whatsAppNumber,
      'promo_text': instance.promoText,
    };
