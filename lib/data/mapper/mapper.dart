import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/request/user_model.dart';
import 'package:ozon/data/response/home_screen_response.dart'as HomeResponse;
import 'package:ozon/data/response/stock_response.dart';
import 'package:ozon/data/response/user_info_response.dart';
import 'package:ozon/domain/model/add_to_cart_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/error_model.dart';
import 'package:ozon/domain/model/estimate_shipping_method.dart';
import 'package:ozon/domain/model/payment_method_model.dart';
import 'package:ozon/domain/model/product_model.dart';
import 'package:ozon/domain/model/register_model.dart';
import 'package:ozon/domain/model/screen_domain_model.dart';
import 'package:ozon/domain/model/stock_model.dart';
import 'package:ozon/domain/model/user_info_model.dart';

import '../../app/constants.dart';
import '../../domain/model/order_model.dart' as OrderModel;
import '../../domain/model/version_model.dart';
import '../response/add_to_cart_response.dart';
import '../response/category_response.dart';
import '../response/countries_response.dart' as CountryResponse;
import '../response/error_response.dart';
import '../response/estimate_shipping_method_response.dart';
import '../response/order_response.dart' as OrderResponse;
import '../response/payment_method_response.dart';

import '../response/register_response.dart';
import '../response/version_response.dart';

extension VersionResultResponseMapper on VersionResultResponse?{
  VersionResultModel toDomain(){
    return VersionResultModel(
      this?.ios.orZero()??Constants.zero,
      this?.android.orZero()??Constants.zero,
    );

  }

}
extension VersionDataResponseMapper on VersionDataResponse?{
  VersionDataModel toDomain(){
    return VersionDataModel(this?.versionResultResponse.toDomain());

  }

}
extension VersionResponseMapper on VersionResponse?{
  VersionModel toDomain(){
    return VersionModel(this?.versionDataResponse.toDomain());

  }


}
extension ErrorResponseMapper on ErrorResponse?{
  ErrorModel toDomain() {
    return ErrorModel(this?.message.orEmpty() ?? Constants.empty
   );
  }
}


extension RegisterResponseMapper on RegisterResponse?{
  RegisterModel toDomain() {
    return RegisterModel(this?.id.orZero() ?? Constants.zero,
      this?.group_id.orZero() ?? Constants.zero,
      this?.created_at.orEmpty() ?? Constants.empty,
      this?.updated_at.orEmpty() ?? Constants.empty,
      this?.created_in.orEmpty() ?? Constants.empty,
      this?.email.orEmpty() ?? Constants.empty,
      this?.firstname.orEmpty() ?? Constants.empty,
      this?.lastname.orEmpty() ?? Constants.empty,
      this?.store_id.orZero() ?? Constants.zero,
      this?.website_id.orZero() ?? Constants.zero,
    );
  }
}
extension CategoryResponseMapper on CategoryResponse?{
  List<CategoryModel> get subCategories {
    return (this?.childrenData
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<CategoryModel>()
        .toList();
  }
  CategoryModel toDomain(){
    return CategoryModel(this?.id.orZero()??Constants.zero,
      this?.parentId.orZero()??Constants.zero,
      this?.name.orEmpty()??Constants.empty,
        this?.image.orEmpty()??Constants.empty,
      this?.isActive.orBooleanFalse()??Constants.falseBoolean,
      this?.position.orZero()??Constants.zero,
      this?.level.orZero()??Constants.zero,
      this?.productCount.orZero()??Constants.zero,
      subCategories


    );

  }


}



// extension FilterMapper on Filter?{
//   FilterModel toDomain() {
//     return FilterModel(field: this?.field.orEmpty() ?? Constants.empty,
//     value:   this?.value.orEmpty() ?? Constants.empty,
//   conditionType:     this?.conditionType.orEmpty() ?? Constants.empty
//
//     );
//   }
// }
// extension FilterGroupMapper on FilterGroup?{
//   List<FilterModel> get filters {
//     return (this?.filters
//         ?.map((childResponse) => childResponse.toDomain()) ??
//         const Iterable.empty())
//         .cast<FilterModel>()
//         .toList();
//   }
//   FilterGroupModel toDomain() {
//     return FilterGroupModel(filters: filters
//
//     );
//   }
// }
// extension SearchCriteriaMapper on SearchCriteria?{
//   List<FilterGroupModel> get filtersGroups {
//     return (this?.filterGroups
//         ?.map((childResponse) => childResponse.toDomain()) ??
//         const Iterable.empty())
//         .cast<FilterGroupModel>()
//         .toList();
//   }
//   SearchCriteriaModel toDomain() {
//     return SearchCriteriaModel(filterGroups: filtersGroups
//
//     );
//   }
// }
//
//
// extension MediaGalleryEntryMapper on MediaGalleryEntry?{
//   MediaGalleryEntryModel toDomain() {
//     return MediaGalleryEntryModel(id: this?.id.orZero() ?? Constants.zero,
//         mediaType:   this?.mediaType.orEmpty() ?? Constants.empty,
//         file:     this?.file.orEmpty() ?? Constants.empty
//
//     );
//   }
// }
//
//
// extension CustomAttributeMapper on CustomAttribute?{
//   CustomAttributeModel toDomain() {
//     return CustomAttributeModel(
//         attributeCode:   this?.attributeCode.orEmpty() ?? Constants.empty,
//         value:     this?.value
//
//     );
//   }
// }
//
//
// extension ProductMapper on Product?{
//   List<CustomAttributeModel> get customerAttributeModelList {
//     return (this?.customAttributes
//         ?.map((childResponse) => childResponse.toDomain()) ??
//         const Iterable.empty())
//         .cast<CustomAttributeModel>()
//         .toList();
//
//
//   }
//   List<MediaGalleryEntryModel> get MediaGalleryEntryModelList {
//     return (this?.mediaGalleryEntries
//         ?.map((childResponse) => childResponse.toDomain()) ??
//         const Iterable.empty())
//         .cast<MediaGalleryEntryModel>()
//         .toList();
//
//
//   }
//   ProductModel toDomain() {
//     return ProductModel(
//         id: this?.id.orZero() ?? Constants.zero,
//         sku:this?.sku.orEmpty() ?? Constants.empty ,
//         name:this?.name.orEmpty() ?? Constants.empty ,
//         price:this?.price.orDoubleZero() ?? Constants.zeroDouble ,
//         status: this?.status.orZero() ?? Constants.zero,
//         visibility: this?.visibility.orZero() ?? Constants.zero,
//         typeId: this?.typeId.orEmpty() ?? Constants.empty,
//         createdAt: this?.createdAt.orEmpty() ?? Constants.empty,
//         updatedAt: this?.updatedAt.orEmpty() ?? Constants.empty,
//         customAttributes: customerAttributeModelList,
//       mediaGalleryEntries: MediaGalleryEntryModelList
//
//     );
//   }
// }

// extension ProductResponseMapper on ProductResponse?{
//   List<ProductModel> get productList {
//     return (this?.items
//         ?.map((childResponse) => childResponse.toDomain()) ??
//         const Iterable.empty())
//         .cast<ProductModel>()
//         .toList();
//   }
//   ProductsModel toDomain() {
//     return ProductsModel(items: productList,
//       searchCriteria: this?.searchCriteria?.toDomain(),
//       totalCount:  this?.totalCount.orZero() ?? Constants.zero,
//
//     );
//   }
// }

extension StockResponseMapper on StockResponse?{
  StockModel toDomain() {
    return StockModel(
           this?.itemId.orZero() ?? Constants.zero,
      this?.productId.orZero() ?? Constants.zero,
      this?.stockId.orZero() ?? Constants.zero,
      this?.isInStock.orBooleanFalse() ?? Constants.falseBoolean,
      this?.minSaleQty.orZero() ?? Constants.zero,
      this?.qty.orZero() ?? Constants.zero,
    );
  }
}

extension UserInfoResponseMapper on UserInfoResponse?{
  UserInfoModel toDomain() {
    return UserInfoModel(this?.id.orZero() ?? Constants.zero,
      this?.email.orEmpty() ?? Constants.empty,
      this?.firstname.orEmpty() ?? Constants.empty,
      this?.lastname.orEmpty() ?? Constants.empty,
      this?.storeId.orZero() ?? Constants.zero,
      this?.websiteId.orZero() ?? Constants.zero,

    );
  }
}

extension AddressMapper on OrderResponse.Address?{
  List<String> get streets {
    return (this?.street
        ?.map((childResponse) => childResponse) ??
        const Iterable.empty())
        .cast<String>()
        .toList();

  }
  List<OrderModel.CustomAttributeModel> get customAttributes {
    return (this?.customAttributes
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<OrderModel.CustomAttributeModel>()
        .toList();
  }
  OrderModel.AddressModel toDomain() {
    return OrderModel.AddressModel(id: this?.id.orZero() ?? Constants.zero, customerId: this?.customerId.orZero() ?? Constants.zero, region: this?.region.toDomain(),
      regionId: this?.regionId.orZero() ?? Constants.zero,
      countryId: this?.countryId.orEmpty() ?? Constants.empty,
      street: streets,telephone: this?.telephone.orEmpty() ?? Constants.empty,
      city:  this?.city.orEmpty() ?? Constants.empty,
      firstname: this?.firstname.orEmpty() ?? Constants.empty,
      lastname: this?.lastname.orEmpty() ?? Constants.empty,
      defaultShipping:  this?.defaultShipping.orBooleanFalse() ?? Constants.falseBoolean,
      defaultBilling: this?.defaultBilling.orBooleanFalse() ?? Constants.falseBoolean,
      customAttributes: customAttributes





    );
  }
}
extension AddressShippingMapper on OrderResponse.AddressShippings?{
  List<String> get streets {
    return (this?.street
        ?.map((childResponse) => childResponse) ??
        const Iterable.empty())
        .cast<String>()
        .toList();

  }

  OrderModel.AddressShippingModel toDomain() {
    return OrderModel.AddressShippingModel(id: this?.id.orZero() ?? Constants.zero, customerId: this?.customerId.orZero() ?? Constants.zero, region: this?.region.orEmpty()??Constants.empty,
        regionId: this?.regionId.orZero() ?? Constants.zero,
        countryId: this?.countryId.orEmpty() ?? Constants.empty,
        street: streets,telephone: this?.telephone.orEmpty() ?? Constants.empty,
        city:  this?.city.orEmpty() ?? Constants.empty,
        firstname: this?.firstname.orEmpty() ?? Constants.empty,
        lastname: this?.lastname.orEmpty() ?? Constants.empty,
        email:  this?.email.orEmpty() ?? Constants.empty,
        sameAsBilling: this?.sameAsBilling.orZero() ?? Constants.zero,
        saveInAdressBook: this?.saveInAdressBook.orZero() ?? Constants.zero,





    );
  }
}

extension RegionMapper on OrderResponse.Region?{
  OrderModel.RegionModel toDomain() {
    return OrderModel.RegionModel(regionCode: this?.regionCode.orEmpty() ?? Constants.empty, region:this?.region.orEmpty() ?? Constants.empty,
      regionId: this?.regionId.orZero()??Constants.zero,



    );
  }
}


extension CustomerExtensionAttributesMapper on OrderResponse.CustomerExtensionAttributes?{
  OrderModel.CustomerExtensionAttributesModel toDomain(){
    return OrderModel.CustomerExtensionAttributesModel(
      isSubscribed:   this?.isSubscribed.orBooleanFalse()??Constants.falseBoolean,

    );

  }

}
extension CustomAttributesMapper on OrderResponse.CustomAttribute?{
  OrderModel.CustomAttributeModel toDomain(){
    return OrderModel.CustomAttributeModel(
      attributeCode:   this?.attributeCode.orEmpty()??Constants.empty,
      value:  this?.value.orEmpty()??Constants.empty,

    );

  }

}

extension ShippingMapper on OrderResponse.Shipping?{
  OrderModel.ShippingsModel toDomain() {
    return OrderModel.ShippingsModel(address: this?.address.toDomain(), method:this?.method.orEmpty() ?? Constants.empty,



    );
  }
}

extension ExtensionAttributesImageMapper on OrderResponse.ImageExtension?{
  OrderModel.ExtensionAttirbuteImageModel toDomain(){
    return OrderModel.ExtensionAttirbuteImageModel(imageUrl: this?.imageUrl.orEmpty()??Constants.empty);
  }
}
extension OrderItemMapper on OrderResponse.OrderItem?{

  OrderModel.OrderItemModel toDomain() {
    return OrderModel.OrderItemModel(itemId: this?.itemId.orZero() ?? Constants.zero,
        sku: this?.sku.orEmpty() ?? Constants.empty,
        qty: this?.qty.orZero() ?? Constants.zero,
        name: this?.name.orEmpty() ?? Constants.empty,
      price: this?.price.orDoubleZero() ?? Constants.zeroDouble,
      productType: this?.productType.orEmpty() ?? Constants.empty,
      quoteId: this?.quoteId.orEmpty() ?? Constants.empty,
        extensionAttirbuteImage: this?.extensionAttributesImage.toDomain()




    );
  }
}


extension ShippingAssignmentMapper on OrderResponse.ShippingAssignment?{

  OrderModel.ShippingAssignmentModel toDomain() {
    return OrderModel.ShippingAssignmentModel(
      shippingsModel:this?.shipping.toDomain(),





    );
  }
}

extension ExtensionAttributesMapper on OrderResponse.ExtensionAttributes?{
  List<OrderModel.ShippingAssignmentModel> get shippingAssignmentList {
    return (this?.shippingAssignments
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<OrderModel.ShippingAssignmentModel>()
        .toList();
  }
  OrderModel.ExtensionAttributesModel toDomain() {
    return OrderModel.ExtensionAttributesModel(shippingAssignments: shippingAssignmentList,






    );
  }
}

extension CurrencyMapper on OrderResponse.Currency?{

  OrderModel.CurrencyModel toDomain() {
    return OrderModel.CurrencyModel(globalCurrencyCode: this?.globalCurrencyCode.orEmpty() ?? Constants.empty,
      baseCurrencyCode: this?.baseCurrencyCode.orEmpty() ?? Constants.empty,
      storeCurrencyCode: this?.storeCurrencyCode.orEmpty() ?? Constants.empty,
      quoteCurrencyCode: this?.quoteCurrencyCode.orEmpty() ?? Constants.empty,
      storeToBaseRate: this?.storeToBaseRate.orDoubleZero() ?? Constants.zeroDouble,
      storeToQuoteRate: this?.storeToQuoteRate.orDoubleZero() ?? Constants.zeroDouble,
      baseToGlobalRate: this?.baseToGlobalRate.orDoubleZero() ?? Constants.zeroDouble,
      baseToQuoteRate: this?.baseToQuoteRate.orDoubleZero() ?? Constants.zeroDouble,



    );
  }
}

extension BillingAddressMapper on OrderResponse.BillingAddress?{
  List<String> get streets {
    return (this?.street
        ?.map((childResponse) => childResponse) ??
        const Iterable.empty())
        .cast<String>()
        .toList();

  }

  OrderModel.BillingAddressModel toDomain() {

    return OrderModel.BillingAddressModel(id: this?.id.orZero() ?? Constants.zero,
      region: this?.region.orEmpty() ?? Constants.empty,

      countryId: this?.countryId.orEmpty() ?? Constants.empty,
      regionCode: this?.regionCode.orEmpty() ?? Constants.empty,
      street: this?.street,
      telephone: this?.telephone.orEmpty() ?? Constants.empty,

      city: this?.city.orEmpty() ?? Constants.empty,
      firstname: this?.firstname.orEmpty() ?? Constants.empty,
      lastname: this?.lastname.orEmpty() ?? Constants.empty,
      customerId: this?.customerId.orZero() ?? Constants.zero,
      email: this?.email.orEmpty() ?? Constants.empty,
    );
  }
}


extension CustomerMapper on OrderResponse.Customer?{
  List<OrderModel.AddressModel> get addresses {
    return (this?.addresses
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<OrderModel.AddressModel>()
        .toList();

  }
  List<OrderModel.CustomAttributeModel> get attributes {
    return (this?.customAttributes
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<OrderModel.CustomAttributeModel>()
        .toList();

  }

  OrderModel.CustomerModel toDomain() {

    return OrderModel.CustomerModel(id: this?.id.orZero() ?? Constants.zero,
      groupId: this?.groupId.orZero() ?? Constants.zero,
      defaultBilling: this?.defaultBilling.orEmpty() ?? Constants.empty,
      defaultShipping: this?.defaultShipping.orEmpty() ?? Constants.empty,
      createdAt: this?.createdAt.orEmpty() ?? Constants.empty,
      updatedAt: this?.updatedAt.orEmpty() ?? Constants.empty,
      createdIn: this?.createdIn.orEmpty() ?? Constants.empty,
      email: this?.email.orEmpty() ?? Constants.empty,
      firstname: this?.firstname.orEmpty() ?? Constants.empty,
      lastname: this?.lastname.orEmpty() ?? Constants.empty,
      storeId: this?.storeId.orZero() ?? Constants.zero,
      websiteId: this?.websiteId.orZero() ?? Constants.zero,
      addresses: addresses,
      disableAutoGroupChange: this?.disableAutoGroupChange.orZero() ?? Constants.zero,
      extensionAttributes: this?.extensionAttributes.toDomain(),
      customAttributes: attributes,

    );
  }
}


extension OrderResponseMapper on OrderResponse.OrderResponse?{
  List<OrderModel.OrderItemModel> get items {
    return (this?.items
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<OrderModel.OrderItemModel>()
        .toList();

  }


  OrderModel.OrderModel toDomain() {

    return OrderModel.OrderModel(id: this?.id.orZero() ?? Constants.zero,

      createdAt: this?.createdAt.orEmpty() ?? Constants.empty,
      updatedAt: this?.updatedAt.orEmpty() ?? Constants.empty,

      isActive: this?.isActive.orBooleanFalse() ?? Constants.falseBoolean,
      isVirtual: this?.isVirtual.orBooleanFalse() ?? Constants.falseBoolean,
      items: items,
      itemsCount: this?.itemsCount.orZero() ?? Constants.zero,
      itemsQty: this?.itemsQty.orZero() ?? Constants.zero,
      storeId: this?.storeId.orZero() ?? Constants.zero,
      customer: this?.customer.toDomain(),
      billingAddress: this?.billingAddress.toDomain(),
      origOrderId: this?.origOrderId.orZero() ?? Constants.zero,
      currency: this?.currency.toDomain(),
      customerIsGuest: this?.isVirtual.orBooleanFalse() ?? Constants.falseBoolean,
      customerNoteNotify: this?.customerNoteNotify.orBooleanFalse() ?? Constants.falseBoolean,
      customerTaxClassId: this?.customerTaxClassId.orZero() ?? Constants.zero,

      extensionAttributes: this?.extensionAttributes.toDomain()
    );
  }
}

extension AddToCartResponseMapper on AddToCartResponse?{
  AddToCartModel toDomain(){
    return AddToCartModel(
     itemId:  this?.itemId.orZero()??Constants.zero,
    sku:   this?.sku.orEmpty()??Constants.empty,
      qty:  this?.qty.orZero()??Constants.zero,
      name:   this?.name.orEmpty()??Constants.empty,
      price:   this?.price.orDoubleZero()??Constants.zeroDouble,
      productType:   this?.productType.orEmpty()??Constants.empty,
      quoteId:   this?.quoteId.orEmpty()??Constants.empty,
      extensionAttirbuteImageModel: this?.extensionAttributesImage.toDomain()
    );

  }

}



extension BrandScreenMapper on HomeResponse.Brand?{
  BrandDomain toDomain(){
    return BrandDomain(
      label:  this?.label.orEmpty()??Constants.empty,
      url:   this?.url.orEmpty()??Constants.empty,
      thumbnailUrl:  this?.thumbnail.orEmpty()??Constants.empty,

    );

  }

}


extension ProductScreenMapper on HomeResponse.Product?{
  ProductDomain toDomain(){
    return ProductDomain(
      id:  this?.productId.orEmpty()??Constants.empty,
      name:   this?.name.orEmpty()??Constants.empty,
      price:  this?.price.orEmpty()??Constants.empty,
      specialPrice:  this?.specialPrice.orEmpty()??Constants.empty,
      imageUrl:  this?.image.orEmpty()??Constants.empty,
      url:  this?.url.orEmpty()??Constants.empty,
      discount:  this?.discount.orEmpty()??Constants.empty,
      isWishlisted:  this?.isWishlisted.orEmpty()??Constants.empty,
      sku: this?.sku.orEmpty()??Constants.empty
    );

  }

}

extension CategoryChildMapper on HomeResponse.CategoryChild?{
  CategoryChildDomain toDomain(){
    return CategoryChildDomain(
      id:  this?.categoryId.orEmpty()??Constants.empty,
      name:   this?.name.orEmpty()??Constants.empty,
      imageUrl:  this?.image.orEmpty()??Constants.empty,

    );

  }

}
extension CategoryComponentMapper on HomeResponse.CategoryComponent?{
  List<CategoryChildDomain> get items {
    return (this?.children
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<CategoryChildDomain>()
        .toList();

  }


  CategoryComponentDomain toDomain() {

    return CategoryComponentDomain(title: this?.title.orEmpty() ?? Constants.empty,

        categoryId: this?.categoryId.orEmpty() ?? Constants.empty,
        children: items,


    );
  }
}
extension CategoryComponentDataMapper on HomeResponse.CategoryComponentData?{
  List<CategoryComponentDomain> get items {
    return (this?.categoryComponent
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<CategoryComponentDomain>()
        .toList();

  }


  CategoryComponentListData toDomain() {

    return CategoryComponentListData(categoryComponentDomainList: items


    );
  }
}
extension SliderComponentDataMapper on HomeResponse.SliderComponentData?{
  SliderComponentDomain toDomain(){
    return SliderComponentDomain(


      imageUrl:  this?.image.orEmpty()??Constants.empty,
      categoryId:   this?.categoryId.orEmpty()??Constants.empty,

    );

  }

}

extension ComponentMapper on HomeResponse.Component?{



  ComponentDomain toDomain(){
    dynamic data;
    if(this?.type == "slider_component_di"){
      data = (this?.componentData
          ?.map((childResponse) => childResponse.toDomain()) ??
          const Iterable.empty())
          .cast<SliderComponentDomain>()
          .toList();

    }else if(this?.type =="category_component_di"){
      data = (this?.componentData['category_component']
          ?.map((childResponse) => childResponse.toDomain()) ??
          const Iterable.empty())
          .cast<CategoryComponentDomain>()
          .toList();
    }else if(this?.type =="products_component_di"){
      data = (this?.componentData
          ?.map((childResponse) => childResponse.toDomain()) ??
          const Iterable.empty())
          .cast<ProductDomain>()
          .toList();
    }else if(this?.type =="brands_component_di"){
      data = (this?.componentData
          ?.map((childResponse) => childResponse.toDomain()) ??
          const Iterable.empty())
          .cast<BrandDomain>()
          .toList();
    }
    return ComponentDomain(
      data: data,


      id:  this?.componentId.orEmpty()??Constants.empty,
      screenId:   this?.screenId.orEmpty()??Constants.empty,
      sortId:   this?.sortId.orEmpty()??Constants.empty,
      type:   this?.type.orEmpty()??Constants.empty,

    );

  }

}


extension CountryResponseMapper on CountryResponse.CountryResponse?{

  CountryModel toDomain() {
    return CountryModel( this?.id.orEmpty()??Constants.empty,
      this?.twoLetterAbbreviation.orEmpty()??Constants.empty,
      this?.threeLetterAbbreviation.orEmpty()??Constants.empty,
        this?.fullNameLocale.orEmpty()??Constants.empty,
        this?.fullNameEnglish.orEmpty()??Constants.empty,
         this?.extensionAttributes.toDomain()
    );
  }
}

extension EstimateShippingMethodResponseMapper on EstimateShippingMethodResponse?{

  EstimateShippingMethod toDomain() {
    return EstimateShippingMethod( this?.methodTitle.orEmpty()??Constants.empty,
        this?.amount.orDoubleZero()??Constants.zeroDouble,
        this?.baseAmount.orDoubleZero()??Constants.zeroDouble,
        this?.available.orBooleanFalse()??Constants.falseBoolean,
        this?.errorMessage.orEmpty()??Constants.empty,
        this?.priceExclTax.orDoubleZero()??Constants.zeroDouble,
      this?.priceInclTax.orDoubleZero()??Constants.zeroDouble,
      this?.carrierCode.orEmpty()??Constants.empty,
      this?.methodCode.orEmpty()??Constants.empty,
      this?.carrierTitle.orEmpty()??Constants.empty
    );
  }
}

extension PaymentMethodResponseMapper on PaymentMethodResponse?{

  PaymentMethodModel toDomain() {
    return PaymentMethodModel( this?.code.orEmpty()??Constants.empty,

        this?.title.orEmpty()??Constants.empty
    );
  }
}
extension ExtensionAttributesAddCartImageMapper on ExtensionAttributesImage?{
 ExtensionAttirbuteImageModel toDomain(){
    return ExtensionAttirbuteImageModel(imageUrl: this?.imageUrl.orEmpty()??Constants.empty);
  }
}
extension ExtensionAttributesCountryMapper on CountryResponse.ExtensionAttributes?{
  ExtensionAttributes toDomain(){
    return ExtensionAttributes( this?.image.orEmpty()??Constants.empty);
  }
}