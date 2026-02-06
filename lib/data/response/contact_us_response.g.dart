// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_us_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactUsDataResponse _$ContactUsDataResponseFromJson(
        Map<String, dynamic> json) =>
    ContactUsDataResponse(
      contactId: json['contact_id'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
    );

Map<String, dynamic> _$ContactUsDataResponseToJson(
        ContactUsDataResponse instance) =>
    <String, dynamic>{
      'contact_id': instance.contactId,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

ContactUsResponse _$ContactUsResponseFromJson(Map<String, dynamic> json) =>
    ContactUsResponse(
      contactus: (json['items'] as List<dynamic>)
          .map((e) => ContactUsDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContactUsResponseToJson(ContactUsResponse instance) =>
    <String, dynamic>{
      'items': instance.contactus.map((e) => e.toJson()).toList(),
    };
