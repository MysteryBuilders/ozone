
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/app_prefrences.dart';
import '../../app/constants.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "Content-Type";
const String ACCEPT = "accept";
const String MULTI_FORM_DATA="application/json";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioMapFactory {
  final AppPreferences _appPreferences;

  DioMapFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();

    String language = await _appPreferences.getAppLanguage();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      DEFAULT_LANGUAGE: language,
      // Constants.headerKey:Constants.headerValue

    };

    dio.options = BaseOptions(
        baseUrl: Constants.googlePlacesUrl,
        headers: headers,
        contentType: APPLICATION_JSON,
        receiveTimeout:const Duration(milliseconds:Constants.apiTimeOut ) ,
        followRedirects: true,

        validateStatus: (status) => true,
        sendTimeout: const Duration(milliseconds:Constants.apiTimeOut ) );

    if (!kReleaseMode) {
      // its debug mode so print app logs
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
