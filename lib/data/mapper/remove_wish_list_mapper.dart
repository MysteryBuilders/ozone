import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/response/remove_wish_list_response.dart';
import 'package:ozon/domain/model/remove_wishlist_model.dart';

import '../../app/constants.dart';

extension RemoveWishListResponseMapper on RemoveWishListResponse?{
  RemoveWishListModel toDomain(){
    return RemoveWishListModel(
      this?.success.orBooleanFalse()??Constants.falseBoolean,
      this?.message.orEmpty()??Constants.empty,
    );

  }

}