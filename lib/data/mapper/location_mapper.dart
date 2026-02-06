import 'package:ozon/app/constants.dart';
import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/response/location_response.dart';
import 'package:ozon/domain/model/location_model.dart';

extension LocationResponseMapper on LocationResponse?{
  LocationModel toDomain(){
    return LocationModel(
      this?.locationId.orEmpty()??Constants.empty,
      this?.visitorId.orEmpty()??Constants.empty,
      this?.customerId.orEmpty()??Constants.empty,
      this?.quoteId.orEmpty()??Constants.empty,
      this?.countryId.orEmpty()??Constants.empty,
      this?.regionId.orEmpty()??Constants.empty,
      this?.region.orEmpty()??Constants.empty,
      this?.websiteId.orEmpty()??Constants.empty,
      this?.sourceCode.orEmpty()??Constants.empty,
    );

  }

}