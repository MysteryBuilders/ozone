import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/response/remove_wish_list_response.dart';
import 'package:ozon/domain/model/city_model.dart';
import 'package:ozon/domain/model/remove_wishlist_model.dart';

import '../../app/constants.dart';
import '../response/city_response.dart';

extension CityResponseMapper on CityResponse?{
  CityModel toDomain(){
    return CityModel(
      this?.entity_id.orEmpty()??Constants.empty,
      this?.states_name.orEmpty()??Constants.empty,
      this?.cities_name.orEmpty()??Constants.empty,
    );

  }

}