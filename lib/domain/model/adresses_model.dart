// Domain model for Customer
class CustomerDomain {
  final int id;
  final int groupId;

  final String createdAt;
  final String updatedAt;
  final String createdIn;
  final String email;
  final String firstname;
  final String lastname;
  final int storeId;
  final int websiteId;
  final List<AddressDomain> addresses;
  final int disableAutoGroupChange;
  final ExtensionAttributesDomain extensionAttributes;
  final List<CustomAttributeDomain> customAttributes;

  CustomerDomain({
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
}

// Domain model for Address
class AddressDomain {
  final int id;
  final int customerId;
  final RegionDomain region;
  final int regionId;
  final String countryId;
  final List<String> street;
  final String telephone;
  final String city;
  final String firstname;
  final String lastname;
  final bool defaultShipping;
  final bool defaultBilling;
  final List<CustomAttributeDomain> customAttributes;
  final String postalCode;

  AddressDomain({
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
    required this.postalCode
  });
}

// Domain model for Region
class RegionDomain {

  final String region;
  final int regionId;

  RegionDomain({

    required this.region,
    required this.regionId,
  });
}

// Domain model for CustomAttribute
class CustomAttributeDomain {
  final String attributeCode;
  final String value;

  CustomAttributeDomain({
    required this.attributeCode,
    required this.value,
  });
}

// Domain model for ExtensionAttributes
class ExtensionAttributesDomain {
  final bool isSubscribed;

  ExtensionAttributesDomain({
    required this.isSubscribed,
  });
}
