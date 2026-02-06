import 'package:json_annotation/json_annotation.dart';

part 'order_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'is_active')
  bool? isActive;

  @JsonKey(name: 'is_virtual')
  bool? isVirtual;

  @JsonKey(name: 'items')
  List<OrderItem> items;

  @JsonKey(name: 'items_count')
  int? itemsCount;

  @JsonKey(name: 'items_qty')
  int? itemsQty;

  @JsonKey(name: 'customer')
  Customer? customer;

  @JsonKey(name: 'billing_address')
  BillingAddress? billingAddress;

  @JsonKey(name: 'orig_order_id')
  int? origOrderId;

  @JsonKey(name: 'currency')
  Currency? currency;

  @JsonKey(name: 'customer_is_guest')
  bool? customerIsGuest;

  @JsonKey(name: 'customer_note_notify')
  bool? customerNoteNotify;

  @JsonKey(name: 'customer_tax_class_id')
  int? customerTaxClassId;

  @JsonKey(name: 'store_id')
  int? storeId;

  @JsonKey(name: 'extension_attributes')
  ExtensionAttributes? extensionAttributes;

  OrderResponse({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.isVirtual,
    required this.items,
    required this.itemsCount,
    required this.itemsQty,
    required this.customer,
    required this.billingAddress,
    required this.origOrderId,
    required this.currency,
    required this.customerIsGuest,
    required this.customerNoteNotify,
    required this.customerTaxClassId,
    required this.storeId,
    required this.extensionAttributes,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) => _$OrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
@JsonSerializable(explicitToJson: true)
class OrderItem {
  @JsonKey(name: 'item_id')
  int? itemId;

  @JsonKey(name: 'sku')
  String? sku;

  @JsonKey(name: 'qty')
  int? qty;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'price')
  double? price;

  @JsonKey(name: 'product_type')
  String? productType;

  @JsonKey(name: 'quote_id')
  String? quoteId;
  @JsonKey(name: 'extension_attributes')
  ImageExtension? extensionAttributesImage;

  OrderItem({
    required this.itemId,
    required this.sku,
    required this.qty,
    required this.name,
    required this.price,
    required this.productType,
    required this.quoteId,
    required this.extensionAttributesImage
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
@JsonSerializable()
class ImageExtension{
  @JsonKey(name: 'image_url')
  String? imageUrl;
  ImageExtension({
  required this.imageUrl});
  factory ImageExtension.fromJson(Map<String, dynamic> json) => _$ImageExtensionFromJson(json);
  Map<String, dynamic> toJson() => _$ImageExtensionToJson(this);

}
@JsonSerializable(explicitToJson: true)
class Customer {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'group_id')
  int? groupId;

  @JsonKey(name: 'default_billing')
  String? defaultBilling;

  @JsonKey(name: 'default_shipping')
  String? defaultShipping;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'created_in')
  String? createdIn;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'firstname')
  String? firstname;

  @JsonKey(name: 'lastname')
  String? lastname;

  @JsonKey(name: 'store_id')
  int? storeId;

  @JsonKey(name: 'website_id')
  int? websiteId;

  @JsonKey(name: 'addresses')
  List<Address>? addresses;

  @JsonKey(name: 'disable_auto_group_change')
  int? disableAutoGroupChange;

  @JsonKey(name: 'extension_attributes')
  CustomerExtensionAttributes? extensionAttributes;

  @JsonKey(name: 'custom_attributes')
  List<CustomAttribute>? customAttributes;

  Customer({
    required this.id,
    required this.groupId,
    required this.defaultBilling,
    required this.defaultShipping,
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

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
@JsonSerializable(explicitToJson: true)
class Address {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'customer_id')
  int? customerId;

  @JsonKey(name: 'region')
  Region? region;

  @JsonKey(name: 'region_id')
  int? regionId;

  @JsonKey(name: 'country_id')
  String? countryId;

  @JsonKey(name: 'street')
  List<String>? street;

  @JsonKey(name: 'telephone')
  String? telephone;

  @JsonKey(name: 'city')
  String? city;

  @JsonKey(name: 'firstname')
  String? firstname;

  @JsonKey(name: 'lastname')
  String? lastname;

  @JsonKey(name: 'default_shipping')
  bool? defaultShipping;

  @JsonKey(name: 'default_billing')
  bool? defaultBilling;

  @JsonKey(name: 'custom_attributes')
  List<CustomAttribute>? customAttributes;

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
    required this.defaultShipping,
    required this.defaultBilling,
    required this.customAttributes,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Region {
  @JsonKey(name: 'region_code')
  String? regionCode;

  @JsonKey(name: 'region')
  String? region;

  @JsonKey(name: 'region_id')
  int? regionId;

  Region({
    required this.regionCode,
    required this.region,
    required this.regionId,
  });

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);
}
@JsonSerializable(explicitToJson: true)
class BillingAddress {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'region')
  String? region;



  @JsonKey(name: 'region_code')
  String? regionCode;

  @JsonKey(name: 'country_id')
  String? countryId;

  @JsonKey(name: 'street')
  List<String>? street;

  @JsonKey(name: 'telephone')
  String? telephone;



  @JsonKey(name: 'city')
  String? city;

  @JsonKey(name: 'firstname')
  String? firstname;

  @JsonKey(name: 'lastname')
  String? lastname;

  @JsonKey(name: 'customer_id')
  int? customerId;

  @JsonKey(name: 'email')
  String? email;

  BillingAddress({
    required this.id,
    required this.region,

    required this.regionCode,
    required this.countryId,
    required this.street,
    required this.telephone,

    required this.city,
    required this.firstname,
    required this.lastname,
    required this.customerId,
    required this.email,
  });

  factory BillingAddress.fromJson(Map<String, dynamic> json) => _$BillingAddressFromJson(json);
  Map<String, dynamic> toJson() => _$BillingAddressToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Currency {
  @JsonKey(name: 'global_currency_code')
  String? globalCurrencyCode;

  @JsonKey(name: 'base_currency_code')
  String? baseCurrencyCode;

  @JsonKey(name: 'store_currency_code')
  String? storeCurrencyCode;

  @JsonKey(name: 'quote_currency_code')
  String? quoteCurrencyCode;

  @JsonKey(name: 'store_to_base_rate')
  double? storeToBaseRate;

  @JsonKey(name: 'store_to_quote_rate')
  double? storeToQuoteRate;

  @JsonKey(name: 'base_to_global_rate')
  double? baseToGlobalRate;

  @JsonKey(name: 'base_to_quote_rate')
  double? baseToQuoteRate;

  Currency({
    required this.globalCurrencyCode,
    required this.baseCurrencyCode,
    required this.storeCurrencyCode,
    required this.quoteCurrencyCode,
    required this.storeToBaseRate,
    required this.storeToQuoteRate,
    required this.baseToGlobalRate,
    required this.baseToQuoteRate,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}
@JsonSerializable(explicitToJson: true)
class ExtensionAttributes {
  @JsonKey(name: 'shipping_assignments')
  List<ShippingAssignment>? shippingAssignments;

  ExtensionAttributes({
    required this.shippingAssignments,
  });

  factory ExtensionAttributes.fromJson(Map<String, dynamic> json) => _$ExtensionAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$ExtensionAttributesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ShippingAssignment {
  // @JsonKey(name: 'shipping')
  // Shipping? shipping;

  @JsonKey(name: 'shipping')
  Shipping? shipping;

  ShippingAssignment({
    // required this.shipping,
    required this.shipping,
  });

  factory ShippingAssignment.fromJson(Map<String, dynamic> json) => _$ShippingAssignmentFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingAssignmentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Shipping {
  @JsonKey(name: 'address')
  AddressShippings? address;

  @JsonKey(name: 'method')
  String? method;

  Shipping({
    required this.address,
    required this.method,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) => _$ShippingFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CustomerExtensionAttributes {
  @JsonKey(name: 'is_subscribed')
  bool? isSubscribed;

  CustomerExtensionAttributes({
    required this.isSubscribed,
  });

  factory CustomerExtensionAttributes.fromJson(Map<String, dynamic> json) =>
      _$CustomerExtensionAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerExtensionAttributesToJson(this);
}
@JsonSerializable()
class CustomAttribute {
  @JsonKey(name: 'attribute_code')
  String? attributeCode;

  @JsonKey(name: 'value')
  String? value;

  CustomAttribute({
    required this.attributeCode,
    required this.value,
  });

  factory CustomAttribute.fromJson(Map<String, dynamic> json) =>
      _$CustomAttributeFromJson(json);

  Map<String, dynamic> toJson() => _$CustomAttributeToJson(this);
}


@JsonSerializable(explicitToJson: true)
class AddressShippings {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'customer_id')
  int? customerId;

  @JsonKey(name: 'region')
  String? region;

  @JsonKey(name: 'region_id')
  int? regionId;

  @JsonKey(name: 'country_id')
  String? countryId;

  @JsonKey(name: 'street')
  List<String>? street;

  @JsonKey(name: 'telephone')
  String? telephone;

  @JsonKey(name: 'city')
  String? city;

  @JsonKey(name: 'firstname')
  String? firstname;

  @JsonKey(name: 'lastname')
  String? lastname;
  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'same_as_billing')
  int? sameAsBilling;

  @JsonKey(name: 'save_in_address_book')
  int? saveInAdressBook;



  AddressShippings({
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
    required this.email,
    required this.sameAsBilling,
    required this.saveInAdressBook,
  });

  factory AddressShippings.fromJson(Map<String, dynamic> json) => _$AddressShippingsFromJson(json);
  Map<String, dynamic> toJson() => _$AddressShippingsToJson(this);
}

