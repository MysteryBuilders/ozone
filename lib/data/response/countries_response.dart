import 'package:json_annotation/json_annotation.dart';

part 'countries_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'two_letter_abbreviation')
  String? twoLetterAbbreviation;
  @JsonKey(name: 'three_letter_abbreviation')
  String? threeLetterAbbreviation;
  @JsonKey(name: 'full_name_locale')
  String? fullNameLocale;
  @JsonKey(name: 'full_name_english')
  String? fullNameEnglish;
  @JsonKey(name: 'extension_attributes')
  final ExtensionAttributes extensionAttributes;
  CountryResponse(this.id,this.twoLetterAbbreviation,this.threeLetterAbbreviation,this.fullNameLocale,this.fullNameEnglish,this.extensionAttributes);
  factory CountryResponse.fromJson(Map<String, dynamic> json) => _$CountryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CountryResponseToJson(this);
}

@JsonSerializable()
class ExtensionAttributes {
  final String image;

  ExtensionAttributes({required this.image});

  factory ExtensionAttributes.fromJson(Map<String, dynamic> json) =>
      _$ExtensionAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$ExtensionAttributesToJson(this);
}