// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countries_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryResponse _$CountryResponseFromJson(Map<String, dynamic> json) =>
    CountryResponse(
      json['id'] as String?,
      json['two_letter_abbreviation'] as String?,
      json['three_letter_abbreviation'] as String?,
      json['full_name_locale'] as String?,
      json['full_name_english'] as String?,
      ExtensionAttributes.fromJson(
          json['extension_attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CountryResponseToJson(CountryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'two_letter_abbreviation': instance.twoLetterAbbreviation,
      'three_letter_abbreviation': instance.threeLetterAbbreviation,
      'full_name_locale': instance.fullNameLocale,
      'full_name_english': instance.fullNameEnglish,
      'extension_attributes': instance.extensionAttributes.toJson(),
    };

ExtensionAttributes _$ExtensionAttributesFromJson(Map<String, dynamic> json) =>
    ExtensionAttributes(
      image: json['image'] as String,
    );

Map<String, dynamic> _$ExtensionAttributesToJson(
        ExtensionAttributes instance) =>
    <String, dynamic>{
      'image': instance.image,
    };
