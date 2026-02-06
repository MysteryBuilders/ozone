import 'package:ozon/app/constants.dart';
import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/response/splash_response.dart';
import 'package:ozon/domain/model/splash_model.dart';

extension ImageSplashResponseMapper on ImageSplashResponse?{
  ImageSplashModel toDomain(){
    return ImageSplashModel(
      this?.imageUrl.orEmpty()??Constants.empty,
      this?.type.orEmpty()??Constants.empty,
      this?.id.orEmpty()??Constants.empty,




    );

  }



}

extension SplashResponseMapper on SplashResponse?{
  List<ImageSplashModel> get list {
    return (this?.imageSplashList
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<ImageSplashModel>()
        .toList();

  }

  SplashModel toDomain(){
    return SplashModel(this?.gif.orEmpty()??Constants.empty,
        this?.timeout.orZero()??Constants.zero,
        list);
  }



}