import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/response/promo_response.dart';
import 'package:ozon/domain/model/new_login_model.dart';
import 'package:ozon/domain/model/promo_model.dart';

import '../../app/constants.dart';
import '../response/new_login_response.dart';

extension NewLoginResponseMapper on NewLoginResponse?{
  NewLoginModel toDomain(){
    return NewLoginModel( this?.token.orEmpty()??Constants.empty,






    );

  }



}