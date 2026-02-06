import 'package:json_annotation/json_annotation.dart';
part 'contact_us_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ContactUsDataResponse {
  @JsonKey(name: 'contact_id')
  final String contactId;

  @JsonKey(name: 'email')
  final String email;



  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'latitude')
  final String latitude;
  @JsonKey(name: 'longitude')
  final String longitude;
  ContactUsDataResponse({
    required this.contactId,
    required this.email,

    required this.phone,
    required this.address,
    required this.latitude,
    required this.longitude,});
  factory ContactUsDataResponse.fromJson(Map<String, dynamic> json) => _$ContactUsDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ContactUsDataResponseToJson(this);

}
@JsonSerializable(explicitToJson: true)
class ContactUsResponse{
  @JsonKey(name: 'items')
  final List<ContactUsDataResponse> contactus;
  ContactUsResponse({required this.contactus});
  factory ContactUsResponse.fromJson(Map<String, dynamic> json) => _$ContactUsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ContactUsResponseToJson(this);

}