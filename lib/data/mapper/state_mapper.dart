import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/response/remove_wish_list_response.dart';
import 'package:ozon/data/response/state_response.dart';
import 'package:ozon/domain/model/city_model.dart';
import 'package:ozon/domain/model/remove_wishlist_model.dart';
import 'package:ozon/domain/model/state_model.dart';

import '../../app/constants.dart';
import '../response/city_response.dart';

extension StateResponseMapper on StateResponse?{
  StateModel toDomain(){
    return StateModel(
      this?.stateId.orEmpty()??Constants.empty,
      this?.name.orEmpty()??Constants.empty,

    );

  }

}