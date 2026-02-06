// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      id: (json['id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      isActive: json['is_active'] as bool?,
      isVirtual: json['is_virtual'] as bool?,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemsCount: (json['items_count'] as num?)?.toInt(),
      itemsQty: (json['items_qty'] as num?)?.toInt(),
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      billingAddress: json['billing_address'] == null
          ? null
          : BillingAddress.fromJson(
              json['billing_address'] as Map<String, dynamic>),
      origOrderId: (json['orig_order_id'] as num?)?.toInt(),
      currency: json['currency'] == null
          ? null
          : Currency.fromJson(json['currency'] as Map<String, dynamic>),
      customerIsGuest: json['customer_is_guest'] as bool?,
      customerNoteNotify: json['customer_note_notify'] as bool?,
      customerTaxClassId: (json['customer_tax_class_id'] as num?)?.toInt(),
      storeId: (json['store_id'] as num?)?.toInt(),
      extensionAttributes: json['extension_attributes'] == null
          ? null
          : ExtensionAttributes.fromJson(
              json['extension_attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_active': instance.isActive,
      'is_virtual': instance.isVirtual,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'items_count': instance.itemsCount,
      'items_qty': instance.itemsQty,
      'customer': instance.customer?.toJson(),
      'billing_address': instance.billingAddress?.toJson(),
      'orig_order_id': instance.origOrderId,
      'currency': instance.currency?.toJson(),
      'customer_is_guest': instance.customerIsGuest,
      'customer_note_notify': instance.customerNoteNotify,
      'customer_tax_class_id': instance.customerTaxClassId,
      'store_id': instance.storeId,
      'extension_attributes': instance.extensionAttributes?.toJson(),
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      itemId: (json['item_id'] as num?)?.toInt(),
      sku: json['sku'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      productType: json['product_type'] as String?,
      quoteId: json['quote_id'] as String?,
      extensionAttributesImage: json['extension_attributes'] == null
          ? null
          : ImageExtension.fromJson(
              json['extension_attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'item_id': instance.itemId,
      'sku': instance.sku,
      'qty': instance.qty,
      'name': instance.name,
      'price': instance.price,
      'product_type': instance.productType,
      'quote_id': instance.quoteId,
      'extension_attributes': instance.extensionAttributesImage?.toJson(),
    };

ImageExtension _$ImageExtensionFromJson(Map<String, dynamic> json) =>
    ImageExtension(
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$ImageExtensionToJson(ImageExtension instance) =>
    <String, dynamic>{
      'image_url': instance.imageUrl,
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: (json['id'] as num?)?.toInt(),
      groupId: (json['group_id'] as num?)?.toInt(),
      defaultBilling: json['default_billing'] as String?,
      defaultShipping: json['default_shipping'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      createdIn: json['created_in'] as String?,
      email: json['email'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      storeId: (json['store_id'] as num?)?.toInt(),
      websiteId: (json['website_id'] as num?)?.toInt(),
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      disableAutoGroupChange:
          (json['disable_auto_group_change'] as num?)?.toInt(),
      extensionAttributes: json['extension_attributes'] == null
          ? null
          : CustomerExtensionAttributes.fromJson(
              json['extension_attributes'] as Map<String, dynamic>),
      customAttributes: (json['custom_attributes'] as List<dynamic>?)
          ?.map((e) => CustomAttribute.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'group_id': instance.groupId,
      'default_billing': instance.defaultBilling,
      'default_shipping': instance.defaultShipping,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'created_in': instance.createdIn,
      'email': instance.email,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'store_id': instance.storeId,
      'website_id': instance.websiteId,
      'addresses': instance.addresses?.map((e) => e.toJson()).toList(),
      'disable_auto_group_change': instance.disableAutoGroupChange,
      'extension_attributes': instance.extensionAttributes?.toJson(),
      'custom_attributes':
          instance.customAttributes?.map((e) => e.toJson()).toList(),
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: (json['id'] as num?)?.toInt(),
      customerId: (json['customer_id'] as num?)?.toInt(),
      region: json['region'] == null
          ? null
          : Region.fromJson(json['region'] as Map<String, dynamic>),
      regionId: (json['region_id'] as num?)?.toInt(),
      countryId: json['country_id'] as String?,
      street:
          (json['street'] as List<dynamic>?)?.map((e) => e as String).toList(),
      telephone: json['telephone'] as String?,
      city: json['city'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      defaultShipping: json['default_shipping'] as bool?,
      defaultBilling: json['default_billing'] as bool?,
      customAttributes: (json['custom_attributes'] as List<dynamic>?)
          ?.map((e) => CustomAttribute.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'customer_id': instance.customerId,
      'region': instance.region?.toJson(),
      'region_id': instance.regionId,
      'country_id': instance.countryId,
      'street': instance.street,
      'telephone': instance.telephone,
      'city': instance.city,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'default_shipping': instance.defaultShipping,
      'default_billing': instance.defaultBilling,
      'custom_attributes':
          instance.customAttributes?.map((e) => e.toJson()).toList(),
    };

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      regionCode: json['region_code'] as String?,
      region: json['region'] as String?,
      regionId: (json['region_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'region_code': instance.regionCode,
      'region': instance.region,
      'region_id': instance.regionId,
    };

BillingAddress _$BillingAddressFromJson(Map<String, dynamic> json) =>
    BillingAddress(
      id: (json['id'] as num?)?.toInt(),
      region: json['region'] as String?,
      regionCode: json['region_code'] as String?,
      countryId: json['country_id'] as String?,
      street:
          (json['street'] as List<dynamic>?)?.map((e) => e as String).toList(),
      telephone: json['telephone'] as String?,
      city: json['city'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      customerId: (json['customer_id'] as num?)?.toInt(),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$BillingAddressToJson(BillingAddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'region': instance.region,
      'region_code': instance.regionCode,
      'country_id': instance.countryId,
      'street': instance.street,
      'telephone': instance.telephone,
      'city': instance.city,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'customer_id': instance.customerId,
      'email': instance.email,
    };

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      globalCurrencyCode: json['global_currency_code'] as String?,
      baseCurrencyCode: json['base_currency_code'] as String?,
      storeCurrencyCode: json['store_currency_code'] as String?,
      quoteCurrencyCode: json['quote_currency_code'] as String?,
      storeToBaseRate: (json['store_to_base_rate'] as num?)?.toDouble(),
      storeToQuoteRate: (json['store_to_quote_rate'] as num?)?.toDouble(),
      baseToGlobalRate: (json['base_to_global_rate'] as num?)?.toDouble(),
      baseToQuoteRate: (json['base_to_quote_rate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'global_currency_code': instance.globalCurrencyCode,
      'base_currency_code': instance.baseCurrencyCode,
      'store_currency_code': instance.storeCurrencyCode,
      'quote_currency_code': instance.quoteCurrencyCode,
      'store_to_base_rate': instance.storeToBaseRate,
      'store_to_quote_rate': instance.storeToQuoteRate,
      'base_to_global_rate': instance.baseToGlobalRate,
      'base_to_quote_rate': instance.baseToQuoteRate,
    };

ExtensionAttributes _$ExtensionAttributesFromJson(Map<String, dynamic> json) =>
    ExtensionAttributes(
      shippingAssignments: (json['shipping_assignments'] as List<dynamic>?)
          ?.map((e) => ShippingAssignment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExtensionAttributesToJson(
        ExtensionAttributes instance) =>
    <String, dynamic>{
      'shipping_assignments':
          instance.shippingAssignments?.map((e) => e.toJson()).toList(),
    };

ShippingAssignment _$ShippingAssignmentFromJson(Map<String, dynamic> json) =>
    ShippingAssignment(
      shipping: json['shipping'] == null
          ? null
          : Shipping.fromJson(json['shipping'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShippingAssignmentToJson(ShippingAssignment instance) =>
    <String, dynamic>{
      'shipping': instance.shipping?.toJson(),
    };

Shipping _$ShippingFromJson(Map<String, dynamic> json) => Shipping(
      address: json['address'] == null
          ? null
          : AddressShippings.fromJson(json['address'] as Map<String, dynamic>),
      method: json['method'] as String?,
    );

Map<String, dynamic> _$ShippingToJson(Shipping instance) => <String, dynamic>{
      'address': instance.address?.toJson(),
      'method': instance.method,
    };

CustomerExtensionAttributes _$CustomerExtensionAttributesFromJson(
        Map<String, dynamic> json) =>
    CustomerExtensionAttributes(
      isSubscribed: json['is_subscribed'] as bool?,
    );

Map<String, dynamic> _$CustomerExtensionAttributesToJson(
        CustomerExtensionAttributes instance) =>
    <String, dynamic>{
      'is_subscribed': instance.isSubscribed,
    };

CustomAttribute _$CustomAttributeFromJson(Map<String, dynamic> json) =>
    CustomAttribute(
      attributeCode: json['attribute_code'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$CustomAttributeToJson(CustomAttribute instance) =>
    <String, dynamic>{
      'attribute_code': instance.attributeCode,
      'value': instance.value,
    };

AddressShippings _$AddressShippingsFromJson(Map<String, dynamic> json) =>
    AddressShippings(
      id: (json['id'] as num?)?.toInt(),
      customerId: (json['customer_id'] as num?)?.toInt(),
      region: json['region'] as String?,
      regionId: (json['region_id'] as num?)?.toInt(),
      countryId: json['country_id'] as String?,
      street:
          (json['street'] as List<dynamic>?)?.map((e) => e as String).toList(),
      telephone: json['telephone'] as String?,
      city: json['city'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      email: json['email'] as String?,
      sameAsBilling: (json['same_as_billing'] as num?)?.toInt(),
      saveInAdressBook: (json['save_in_address_book'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddressShippingsToJson(AddressShippings instance) =>
    <String, dynamic>{
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
      'email': instance.email,
      'same_as_billing': instance.sameAsBilling,
      'save_in_address_book': instance.saveInAdressBook,
    };
