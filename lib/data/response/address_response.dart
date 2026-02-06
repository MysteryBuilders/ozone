import 'package:json_annotation/json_annotation.dart';

part 'address_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AddressesResponse {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'group_id')
  final int groupId;



  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'updated_at')
  final String updatedAt;

  @JsonKey(name: 'created_in')
  final String createdIn;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'firstname')
  final String firstname;

  @JsonKey(name: 'lastname')
  final String lastname;

  @JsonKey(name: 'store_id')
  final int storeId;

  @JsonKey(name: 'website_id')
  final int websiteId;

  @JsonKey(name: 'addresses')
  final List<Address> addresses;

  @JsonKey(name: 'disable_auto_group_change')
  final int disableAutoGroupChange;

  @JsonKey(name: 'extension_attributes')
  final ExtensionAttributes extensionAttributes;

  @JsonKey(name: 'custom_attributes')
  final List<CustomAttribute> customAttributes;

  AddressesResponse({
    required this.id,
    required this.groupId,

    required this.createdAt,
    required this.updatedAt,
    required this.createdIn,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.storeId,
    required this.websiteId,
    required this.addresses,
    required this.disableAutoGroupChange,
    required this.extensionAttributes,
    required this.customAttributes,
  });

  factory AddressesResponse.fromJson(Map<String, dynamic> json) => _$AddressesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AddressesResponseToJson(this);
}

@JsonSerializable()
class Address {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'customer_id')
  final int customerId;

  @JsonKey(name: 'region')
  final Region region;

  @JsonKey(name: 'region_id')
  final int regionId;

  @JsonKey(name: 'country_id')
  final String countryId;

  @JsonKey(name: 'street')
  final List<String> street;

  @JsonKey(name: 'telephone')
  final String telephone;

  @JsonKey(name: 'city')
  final String city;

  @JsonKey(name: 'firstname')
  final String firstname;

  @JsonKey(name: 'lastname')
  final String lastname;

  @JsonKey(name: 'default_shipping')
  final bool ?defaultShipping;

  @JsonKey(name: 'default_billing')
  final bool ?defaultBilling;

  @JsonKey(name: 'custom_attributes')
  final List<CustomAttribute> customAttributes;
  @JsonKey(name: 'postcode')
  final String postcode;

  Address({
    required this.id,
    required this.customerId,
    required this.region,
    required this.regionId,
    required this.countryId,
    required this.street,
    required this.telephone,
    required this.city,
    required this.firstname,
    required this.lastname,
     this.defaultShipping,
     this.defaultBilling,
    required this.customAttributes,
    required this.postcode
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Region {


  @JsonKey(name: 'region')
  final String region;

  @JsonKey(name: 'region_id')
  final int regionId;

  Region({

    required this.region,
    required this.regionId,
  });

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);
}

@JsonSerializable()
class CustomAttribute {
  @JsonKey(name: 'attribute_code')
  final String attributeCode;

  @JsonKey(name: 'value')
  final String value;

  CustomAttribute({
    required this.attributeCode,
    required this.value,
  });

  factory CustomAttribute.fromJson(Map<String, dynamic> json) => _$CustomAttributeFromJson(json);
  Map<String, dynamic> toJson() => _$CustomAttributeToJson(this);
}

@JsonSerializable()
class ExtensionAttributes {
  @JsonKey(name: 'is_subscribed')
  final bool isSubscribed;

  ExtensionAttributes({
    required this.isSubscribed,
  });

  factory ExtensionAttributes.fromJson(Map<String, dynamic> json) => _$ExtensionAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$ExtensionAttributesToJson(this);
}
