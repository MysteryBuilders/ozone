import 'package:ozon/app/extensions.dart';

import '../../app/constants.dart';
import '../../domain/model/wishlist_model.dart';
import '../response/wish_list_response.dart';

extension CustomerAttributeItemResponseMapper on CustomerAttributeItemResponse?{
  CustomerAttributeItemModel toDomain(){
    return CustomerAttributeItemModel(
      this?.attributeCode.orEmpty()??Constants.empty,
      this?.value.orEmpty()??Constants.empty,
    );

  }

}


extension ProductItemResponseMapper on ProductItemResponse?{
  List<CustomerAttributeItemModel> get customerAttributeList {
    return (this?.customerAttributeList
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<CustomerAttributeItemModel>()
        .toList();
  }
  ProductItemModel toDomain(){

    return ProductItemModel(
      this?.id.orZero()??Constants.zero,
      this?.sku.orEmpty()??Constants.empty,
      this?.name.orEmpty()??Constants.empty,
      this?.attributeSetId.orZero()??Constants.zero,
      this?.price.orDoubleZero()??Constants.zeroDouble,
      this?.status.orZero()??Constants.zero,
      this?.visibility.orZero()??Constants.zero,
      this?.typeId.orEmpty()??Constants.empty,
      this?.created_at.orEmpty()??Constants.empty,
      this?.updated_at.orEmpty()??Constants.empty,
        customerAttributeList
    );

  }

}

extension WishListItemsResponseMapper on WishListItemsResponse?{
  WishListItemsModel toDomain(){
    return WishListItemsModel(
      this?.id.orZero()??Constants.zero,
      this?.qty.orZero()??Constants.zero,
      this?.productItemResponse.toDomain()
    );

  }

}

extension WishListResponseMapper on WishListResponse?{
  List<WishListItemsModel> get wishListItems {
    return (this?.wishList
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<WishListItemsModel>()
        .toList();
  }
  WishListModel toDomain(){

    return WishListModel(
        this?.customer_id.orZero()??Constants.zero,
        this?.sharing_code.orEmpty()??Constants.empty,

        this?.items_count.orZero()??Constants.zero,

        wishListItems
    );

  }

}