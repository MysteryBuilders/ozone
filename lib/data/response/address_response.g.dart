// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressesResponse _$AddressesResponseFromJson(Map<String, dynamic> json) =>
    AddressesResponse(
      id: (json['id'] as num).toInt(),
      groupId: (json['group_id'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      createdIn: json['created_in'] as String,
      email: json['email'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      storeId: (json['store_id'] as num).toInt(),
      websiteId: (json['website_id'] as num).toInt(),
      addresses: (json['addresses'] as List<dynamic>)
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      disableAutoGroupChange:
          (json['disable_auto_group_change'] as num).toInt(),
      extensionAttributes: ExtensionAttributes.fromJson(
          json['extension_attributes'] as Map<String, dynamic>),
      customAttributes: (json['custom_attributes'] as List<dynamic>)
          .map((e) => CustomAttribute.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddressesResponseToJson(AddressesResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_id': instance.groupId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'created_in': instance.createdIn,
      'email': instance.email,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'store_id': instance.storeId,
      'website_id': instance.websiteId,
      'addresses': instance.addresses.map((e) => e.toJson()).toList(),
      'disable_auto_group_change': instance.disableAutoGroupChange,
      'extension_attributes': instance.extensionAttributes.toJson(),
      'custom_attributes':
          instance.customAttributes.map((e) => e.toJson()).toList(),
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: (json['id'] as num).toInt(),
      customerId: (json['customer_id'] as num).toInt(),
      region: Region.fromJson(json['region'] as Map<String, dynamic>),
      regionId: (json['region_id'] as num).toInt(),
      countryId: json['country_id'] as String,
      street:
          (json['street'] as List<dynamic>).map((e) => e as String).toList(),
      telephone: json['telephone'] as String,
      city: json['city'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      defaultShipping: json['default_shipping'] as bool?,
      defaultBilling: json['default_billing'] as bool?,
      customAttributes: (json['custom_attributes'] as List<dynamic>)
          .map((e) => CustomAttribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      postcode: json['postcode'] as String,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'customer_id': instance.customerId,
      'region': instance.region,
      'region_id': instance.regionId,
      'country_id': instance.countryId,
      'street': instance.street,
      'telephone': instance.telephone,
      'city': instance.city,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'default_shipping': instance.defaultShipping,
      'default_billing': instance.defaultBilling,
      'custom_attributes': instance.customAttributes,
      'postcode': instance.postcode,
    };

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      region: json['region'] as String,
      regionId: (json['region_id'] as num).toInt(),
    );

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'region': instance.region,
      'region_id': instance.regionId,
    };

CustomAttribute _$CustomAttributeFromJson(Map<String, dynamic> json) =>
    CustomAttribute(
      attributeCode: json['attribute_code'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$CustomAttributeToJson(CustomAttribute instance) =>
    <String, dynamic>{
      'attribute_code': instance.attributeCode,
      'value': instance.value,
    };

ExtensionAttributes _$ExtensionAttributesFromJson(Map<String, dynamic> json) =>
    ExtensionAttributes(
      isSubscribed: json['is_subscribed'] as bool,
    );

Map<String, dynamic> _$ExtensionAttributesToJson(
        ExtensionAttributes instance) =>
    <String, dynamic>{
      'is_subscribed': instance.isSubscribed,
    };
