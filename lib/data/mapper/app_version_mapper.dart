import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/response/app_version_response.dart';
import 'package:ozon/domain/model/app_version_model.dart';

import '../../app/constants.dart';

extension AppVersionDataResponseMapper on AppVersionDataResponse?{
  AppVersionDataModel toDomain(){
    return AppVersionDataModel(versionId: this?.versionId.orEmpty()??Constants.empty, ios: this?.ios.orZero()??Constants.zero,
      android: this?.andriod.orZero()??Constants.zero





    );

  }



}
extension AppVersionResponseMapper on AppVersionResponse?{
  List<AppVersionDataModel> get list {
    return (this?.versions
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<AppVersionDataModel>()
        .toList();

  }

  AppVersionModel toDomain(){
    return AppVersionModel(versionsList: list);
  }



}