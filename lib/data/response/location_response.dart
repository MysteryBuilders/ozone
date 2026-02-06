import 'package:json_annotation/json_annotation.dart';

part 'location_response.g.dart';

@JsonSerializable()
class LocationResponse {
  @JsonKey(name: "location_id")
  final String? locationId;
  @JsonKey(name: "visitor_id")
  final String? visitorId;
  @JsonKey(name: "customer_id")
  final String? customerId;
  @JsonKey(name: "quote_id")
  final String? quoteId;
  @JsonKey(name: "country_id")
  final String? countryId;
  @JsonKey(name: "region_id")
  final String? regionId;
  @JsonKey(name: "region")
  final String? region;
  @JsonKey(name: "website_id")
  final String? websiteId;
  @JsonKey(name: "source_code")
  final String? sourceCode;

  LocationResponse ({
    this.locationId,
    this.visitorId,
    this.customerId,
    this.quoteId,
    this.countryId,
    this.regionId,
    this.region,
    this.websiteId,
    this.sourceCode,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return _$LocationResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LocationResponseToJson(this);
  }
}


