import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/response/remove_wish_list_response.dart';
import 'package:ozon/domain/model/add_item_to_wishlist_model.dart';
import 'package:ozon/domain/model/remove_wishlist_model.dart';

import '../../app/constants.dart';
import '../response/add_to_wish_list_response.dart';

extension AddToWishListResponseMapper on AddToWishListResponse?{
  AddItemToWishListModel toDomain(){
    return AddItemToWishListModel(
      this?.success.orBooleanFalse()??Constants.falseBoolean,
      this?.message.orEmpty()??Constants.empty,
    );

  }

}