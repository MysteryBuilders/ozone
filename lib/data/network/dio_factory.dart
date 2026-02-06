
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ozon/domain/model/state_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'dart:convert';
import '../../app/app_prefrences.dart';
import '../../app/constants.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "Content-Type";
const String ACCEPT = "accept";
const String MULTI_FORM_DATA="application/json";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();

    String language = await _appPreferences.getAppLanguage();
    StateModel? stateModel = await _appPreferences.getState();
    String storeCode= await _appPreferences.getStoreCode();
    String sourceCode = await _appPreferences.getSourceCode();
    String stateId = "";
    String deviceType = Platform.isIOS?"IOS":"Android";
    if(stateModel != null){
      stateId = stateModel.stateId!;

    }else{
      stateId ="";
    }
    if(storeCode.isEmpty){
      storeCode = "";
    }

    Map<String, String> headers = {
      CONTENT_TYPE: MULTI_FORM_DATA,
      ACCEPT: APPLICATION_JSON,
      DEFAULT_LANGUAGE: language,

      Constants.headerKey:Constants.headerValue,
      "source-code":sourceCode,
      "store":storeCode
    };
    String url = '${Constants.baseUrl}/${storeCode}/V1/';

    dio.options = BaseOptions(

        baseUrl: Constants.baseUrl,
        headers: headers,
        contentType: MULTI_FORM_DATA,
        receiveTimeout:const Duration(milliseconds:Constants.apiTimeOut ) ,
        followRedirects: true,


        validateStatus: (status) => true,
        sendTimeout: const Duration(milliseconds:Constants.apiTimeOut ) );
    dio.transformer = DefaultTransformer(
      jsonDecodeCallback: jsonDecode,
      jsonEncodeCallback: (data) {
        return jsonEncode(data);
      },
    );
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
