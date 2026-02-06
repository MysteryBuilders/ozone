class OrderModel {

  int? id;


  String? createdAt;


  String? updatedAt;


  bool? isActive;


  bool? isVirtual;


  List<OrderItemModel> items;


  int? itemsCount;


  int? itemsQty;


  CustomerModel? customer;


  BillingAddressModel? billingAddress;


  int? origOrderId;


  CurrencyModel? currency;


  bool? customerIsGuest;


  bool? customerNoteNotify;


  int? customerTaxClassId;


  int? storeId;


  ExtensionAttributesModel? extensionAttributes;

  OrderModel({
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


}

class OrderItemModel {

  int? itemId;


  String? sku;


  int? qty;


  String? name;


  double? price;


  String? productType;


  String? quoteId;
  ExtensionAttirbuteImageModel? extensionAttirbuteImage;

  OrderItemModel({
    required this.itemId,
    required this.sku,
    required this.qty,
    required this.name,
    required this.price,
    required this.productType,
    required this.quoteId,
    required this.extensionAttirbuteImage
  });


}
class ExtensionAttirbuteImageModel{
  String imageUrl;
  ExtensionAttirbuteImageModel({required this.imageUrl});

}
class CustomerModel {

  int? id;


  int? groupId;


  String? defaultBilling;


  String? defaultShipping;


  String? createdAt;


  String? updatedAt;


  String? createdIn;


  String? email;


  String? firstname;


  String? lastname;


  int? storeId;

  int? websiteId;


  List<AddressModel>? addresses;


  int? disableAutoGroupChange;


  CustomerExtensionAttributesModel? extensionAttributes;


  List<CustomAttributeModel>? customAttributes;

  CustomerModel({
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


}
class AddressModel {

  int? id;


  int? customerId;


  RegionModel? region;


  int? regionId;


  String? countryId;


  List<String>? street;


  String? telephone;


  String? city;


  String? firstname;


  String? lastname;


  bool? defaultShipping;


  bool? defaultBilling;


  List<CustomAttributeModel>? customAttributes;

  AddressModel({
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


}

class RegionModel {

  String? regionCode;


  String? region;


  int? regionId;

  RegionModel({
    required this.regionCode,
    required this.region,
    required this.regionId,
  });


}
class BillingAddressModel {

  int? id;


  String? region;





  String? regionCode;


  String? countryId;


  List<String>? street;


  String? telephone;





  String? city;


  String? firstname;


  String? lastname;


  int? customerId;


  String? email;

  BillingAddressModel({
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


}

class CurrencyModel {

  String? globalCurrencyCode;


  String? baseCurrencyCode;


  String? storeCurrencyCode;


  String? quoteCurrencyCode;


  double? storeToBaseRate;


  double? storeToQuoteRate;


  double? baseToGlobalRate;


  double? baseToQuoteRate;

  CurrencyModel({
    required this.globalCurrencyCode,
    required this.baseCurrencyCode,
    required this.storeCurrencyCode,
    required this.quoteCurrencyCode,
    required this.storeToBaseRate,
    required this.storeToQuoteRate,
    required this.baseToGlobalRate,
    required this.baseToQuoteRate,
  });


}

class ExtensionAttributesModel {

  List<ShippingAssignmentModel>? shippingAssignments;

  ExtensionAttributesModel({
    required this.shippingAssignments,
  });


}


class ShippingAssignmentModel {




  ShippingsModel? shippingsModel;

  ShippingAssignmentModel({

    required this.shippingsModel,
  });

 }


class ShippingsModel {

  AddressShippingModel? address;


  String? method;

  ShippingsModel({
    required this.address,
    required this.method,
  });

 }


class CustomerExtensionAttributesModel {

  bool? isSubscribed;

  CustomerExtensionAttributesModel({
    required this.isSubscribed,
  });

 }

class CustomAttributeModel {

  String? attributeCode;


  String? value;

  CustomAttributeModel({
    required this.attributeCode,
    required this.value,
  });


}

class AddressShippingModel {

  int? id;


  int? customerId;


  String? region;


  int? regionId;


  String? countryId;


  List<String>? street;


  String? telephone;


  String? city;


  String? firstname;


  String? lastname;


  String? email;


  int? sameAsBilling;


  int? saveInAdressBook;

  AddressShippingModel({
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


}