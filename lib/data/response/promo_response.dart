import 'package:json_annotation/json_annotation.dart';
part 'promo_response.g.dart';
@JsonSerializable()
class PromoResponse {
  @JsonKey(name:"whats_app_number" )
  final String whatsAppNumber;
  @JsonKey(name:"promo_text" )
  final String promoText;

  PromoResponse({required this.whatsAppNumber, required this.promoText});

  factory PromoResponse.fromJson(Map<String, dynamic> json) => _$PromoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PromoResponseToJson(this);
}