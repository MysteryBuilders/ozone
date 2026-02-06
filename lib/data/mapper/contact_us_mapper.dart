import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/response/app_version_response.dart';
import 'package:ozon/data/response/contact_us_response.dart';
import 'package:ozon/domain/model/app_version_model.dart';
import 'package:ozon/domain/model/contact_us_model.dart';

import '../../app/constants.dart';

extension ContactUsDataResponseMapper on ContactUsDataResponse?{
  ContactUsDataModel toDomain(){
    return ContactUsDataModel(contactId: this?.contactId.orEmpty()??Constants.empty, email: this?.email.orEmpty()??Constants.empty,
        phone: this?.phone.orEmpty()??Constants.empty,
      address: this?.address.orEmpty()??Constants.empty,
      latitude: this?.latitude.orEmpty()??Constants.empty,
      longitude: this?.longitude.orEmpty()??Constants.empty,





    );

  }



}
extension ContactUsResponseMapper on ContactUsResponse?{
  List<ContactUsDataModel> get list {
    return (this?.contactus
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<ContactUsDataModel>()
        .toList();

  }

  ContactUsModel toDomain(){
    return ContactUsModel(contactUsList: list);
  }



}