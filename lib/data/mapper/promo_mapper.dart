import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/response/promo_response.dart';
import 'package:ozon/domain/model/promo_model.dart';

import '../../app/constants.dart';

extension PromoResponseMapper on PromoResponse?{
  PromoModel toDomain(){
    return PromoModel( this?.whatsAppNumber.orEmpty()??Constants.empty,
      this?.promoText.orEmpty()??Constants.empty





    );

  }



}