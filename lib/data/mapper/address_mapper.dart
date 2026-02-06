import 'package:ozon/app/constants.dart';
import 'package:ozon/app/extensions.dart';

import '../../domain/model/adresses_model.dart';
import '../response/address_response.dart';

extension ExtensionAttributesMapper on ExtensionAttributes?{
  ExtensionAttributesDomain toDomain(){
    return ExtensionAttributesDomain(
      isSubscribed: this?.isSubscribed.orBooleanFalse()??Constants.falseBoolean
      ,

    );

  }

}

extension CustomAttributeMapper on CustomAttribute?{
  CustomAttributeDomain toDomain(){
    return CustomAttributeDomain(
      attributeCode: this?.attributeCode.orEmpty()??Constants.empty,
      value:  this?.value.orEmpty()??Constants.empty

    );

  }

}

extension RegionMapper on Region?{
  RegionDomain toDomain(){
    return RegionDomain(

        region:  this?.region.orEmpty()??Constants.empty,
      regionId:  this?.regionId.orZero()??Constants.zero,
    );

  }

}

extension AddressMapper on Address?{
  List<String> get streets {
    return (this?.street
        ?.map((childResponse) => childResponse) ??
        const Iterable.empty())
        .cast<String>()
        .toList();

  }
  List<CustomAttributeDomain> get customerAttibuteList {
    return (this?.customAttributes
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<CustomAttributeDomain>()
        .toList();

  }
  AddressDomain toDomain(){
    return AddressDomain(
      id: this?.id.orZero()??Constants.zero,
      customerId:  this?.customerId.orZero()??Constants.zero,
      region:  this!.region.toDomain(),
      regionId: this?.regionId.orZero()??Constants.zero,
      countryId: this?.countryId.orEmpty()??Constants.empty,
      street: streets,
      telephone: this?.telephone.orEmpty()??Constants.empty,
      city: this?.city.orEmpty()??Constants.empty,
      firstname:  this?.firstname.orEmpty()??Constants.empty,
      lastname: this?.lastname.orEmpty()??Constants.empty,
      defaultBilling: this?.defaultBilling.orBooleanFalse()??Constants.falseBoolean,
      defaultShipping: this?.defaultShipping.orBooleanFalse()??Constants.falseBoolean,
      customAttributes: customerAttibuteList,
      postalCode: this?.postcode.orEmpty()??Constants.empty



    );

  }

}

extension CustomerMapper on AddressesResponse?{
  List<AddressDomain> get addresses {
    return (this?.addresses
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<AddressDomain>()
        .toList();

  }
  List<CustomAttributeDomain> get customerAttibuteList {
    return (this?.customAttributes
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<CustomAttributeDomain>()
        .toList();

  }
  CustomerDomain toDomain(){
    return CustomerDomain(
        id: this?.id.orZero()??Constants.zero,
        groupId:  this?.groupId.orZero()??Constants.zero,



        createdAt: this?.createdAt.orEmpty()??Constants.empty,
        updatedAt: this?.updatedAt.orEmpty()??Constants.empty,
        createdIn: this?.createdIn.orEmpty()??Constants.empty,
        email: this?.email.orEmpty()??Constants.empty,
        firstname: this?.firstname.orEmpty()??Constants.empty,
        lastname: this?.lastname.orEmpty()??Constants.empty,
        storeId: this?.storeId.orZero()??Constants.zero,
        websiteId: this?.websiteId.orZero()??Constants.zero,
        addresses: addresses,
        disableAutoGroupChange: this?.disableAutoGroupChange.orZero()??Constants.zero,
        extensionAttributes: this!.extensionAttributes.toDomain(),
        customAttributes:  customerAttibuteList,



    );

  }


}