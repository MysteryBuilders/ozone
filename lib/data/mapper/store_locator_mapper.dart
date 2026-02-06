import 'package:ozon/app/extensions.dart';
import 'package:ozon/domain/model/store_locator_model.dart';

import '../../app/constants.dart';
import '../response/state_locator_response.dart';

extension StareLocatorResponseMapper on StareLocatorResponse?{
  StoreLocatorModel toDomain(){
    return StoreLocatorModel(
      this?.storeCode.orEmpty()??Constants.empty,
      this?.webSiteId.orZero()??Constants.zero,
      this?.sourceCode.orEmpty()??Constants.empty,
    );

  }

}