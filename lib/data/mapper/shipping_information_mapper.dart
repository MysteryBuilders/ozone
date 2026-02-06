import 'package:ozon/app/constants.dart';
import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/mapper/checkout_mapper.dart';
import 'package:ozon/data/response/shipping_information_response.dart';
import 'package:ozon/domain/model/shipping_information_model.dart';

extension PaymentMethodResponseMapper on PaymentMethod?{
  PaymentMethodInformationModel toDomain(){
    return PaymentMethodInformationModel(
    code:  this?.code.orEmpty()??Constants.empty,
     title:  this?.title.orEmpty()??Constants.empty,
    );

  }

}


extension ShippingInformationResponseMapper on ShippingInformationResponse?{




  ShippingInformationModel toDomain(){
    List<PaymentMethodInformationModel> methods = (this

        ?.paymentMethods
        ?.map((academiesResponse) => academiesResponse.toDomain()) ??
        const Iterable.empty())
        .cast<PaymentMethodInformationModel>()
        .toList();
    return ShippingInformationModel(
       paymentMethods: methods,
      checkOutModel: this!.checkOutResponse.toDomain()


    );

  }

}