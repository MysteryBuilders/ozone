

import 'dart:io';


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:ozon/app/constants.dart';

import 'package:ozon/data/mapper/add_item_to_wish_list_mapper.dart';
import 'package:ozon/data/mapper/app_version_mapper.dart';
import 'package:ozon/data/mapper/brands_mapper.dart';
import 'package:ozon/data/mapper/category_home_mapper.dart';
import 'package:ozon/data/mapper/check_stock_mapper.dart';
import 'package:ozon/data/mapper/checkout_mapper.dart';
import 'package:ozon/data/mapper/generate_invoice_mapper.dart';
import 'package:ozon/data/mapper/home_mapper.dart'as HomeMapper;
import 'package:ozon/data/mapper/city_mapper.dart';
import 'package:ozon/data/mapper/contact_us_mapper.dart';
import 'package:ozon/data/mapper/location_mapper.dart';
import 'package:ozon/data/mapper/mapper.dart';
import 'package:ozon/data/mapper/address_mapper.dart';
import 'package:ozon/data/mapper/my_orders_mapper.dart';
import 'package:ozon/data/mapper/new_login_mapper.dart';
import 'package:ozon/data/mapper/products_mapper.dart';
import 'package:ozon/data/mapper/promo_mapper.dart';
import 'package:ozon/data/mapper/rating_mapper.dart';
import 'package:ozon/data/mapper/remove_wish_list_mapper.dart';
import 'package:ozon/data/mapper/shipping_information_mapper.dart';
import 'package:ozon/data/mapper/sort_category_mapper.dart';
import 'package:ozon/data/mapper/splash_mapper.dart';
import 'package:ozon/data/mapper/state_mapper.dart';
import 'package:ozon/data/mapper/store_locator_mapper.dart';
import 'package:ozon/data/mapper/time_line_mapper.dart';
import 'package:ozon/data/mapper/wishlist_mapper.dart';
import 'package:ozon/data/response/add_to_cart_response.dart';
import 'package:ozon/data/response/error_response.dart';
import 'package:ozon/data/response/my_orders_response.dart';
import 'package:ozon/data/response/new_login_response.dart';
import 'package:ozon/data/response/register_response.dart';
import 'package:ozon/data/response/shipping_information_response.dart';
import 'package:ozon/data/response/sorting_category_response.dart';
import 'package:ozon/domain/model/add_item_to_wishlist_model.dart';
import 'package:ozon/domain/model/add_to_cart_model.dart';
import 'package:ozon/domain/model/adresses_model.dart';
import 'package:ozon/domain/model/app_version_model.dart';
import 'package:ozon/domain/model/category_home_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/check_out_model.dart';
import 'package:ozon/domain/model/check_stock_model.dart';
import 'package:ozon/domain/model/city_model.dart';
import 'package:ozon/domain/model/contact_us_model.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/error_model.dart';
import 'package:ozon/domain/model/estimate_shipping_method.dart';
import 'package:ozon/domain/model/generate_invoice_model.dart';
import 'package:ozon/domain/model/home_screen_model.dart';
import 'package:ozon/domain/model/location_model.dart';
import 'package:ozon/domain/model/my_orders_model.dart';
import 'package:ozon/domain/model/new_login_model.dart';
import 'package:ozon/domain/model/order_model.dart';
import 'package:ozon/domain/model/payment_method_model.dart';

import 'package:ozon/domain/model/promo_model.dart';
import 'package:ozon/domain/model/rating_model.dart';
import 'package:ozon/domain/model/register_model.dart';
import 'package:ozon/domain/model/remove_wishlist_model.dart';
import 'package:ozon/domain/model/shipping_information_model.dart';
import 'package:ozon/domain/model/sorting_category_model.dart';
import 'package:ozon/domain/model/splash_model.dart';
import 'package:ozon/domain/model/state_model.dart';
import 'package:ozon/domain/model/stock_model.dart';
import 'package:ozon/domain/model/store_locator_model.dart';
import 'package:ozon/domain/model/time_line_model.dart';
import 'package:ozon/domain/model/user_info_model.dart';
import 'package:ozon/domain/model/wishlist_model.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';

import '../../app/app_prefrences.dart';
import '../../data/data_source/local_data_source.dart';
import '../../data/data_source/remote_data_source.dart';
import '../../data/network/network_info.dart';
import '../../domain/model/brands_model.dart';
import '../../domain/model/products_model.dart';
import '../../domain/model/version_model.dart';
import '../../domain/repository/repository.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../response/add_to_wish_list_response.dart';
import '../response/remove_wish_list_response.dart';


class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  final AppPreferences _appPreferences;

  RepositoryImpl(this._remoteDataSource, this._networkInfo,
      this._localDataSource,this._appPreferences);


  @override
  Future<Either<Failure, VersionModel>> versions()async {
    if (await _networkInfo.isConnected) {
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
      // its connected to internet, its safe to call API
      try {
        final response = await _remoteDataSource.version(Constants.headerValue,
             stateId, storeCode, deviceType,sourceCode
        );
        print(response.data.status);

        if (response.data.isOk!) {
          // success
          // return either right
          // return data
          return Right(response!.data!.toDomain());
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.data.error ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> login(String userName, String password,String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
        String stateId = "";
        String deviceType = Platform.isIOS?"IOS":"Android";
        String sourceCode = await _appPreferences.getSourceCode();
        if(stateModel != null){
          stateId = stateModel.stateId!;

        }else{
          stateId ="";
        }
        if(storeCode.isEmpty){
          storeCode = "";
        }
        Map<String,dynamic> map ={};
        map['username'] = userName;
        map['password'] = password;
        final response = await _remoteDataSource.login(map,authorization,
            stateId, storeCode, deviceType,sourceCode);



        if (response.response.statusCode == 200) {


          // success
          // return either right
          // return data
          return Right(response.data.toString());
        } else  {
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
             errorModel.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, RegisterModel>> register(String email, String firstName, String lastName, String password,String authorization,String phoneNumber,String countryCode,String stateId,String storeCode)async {


    if (await _networkInfo.isConnected) {
      String language = await _appPreferences.getAppLanguage();
      StateModel? stateModel = await _appPreferences.getState();
      String storeCode= await _appPreferences.getStoreCode();
      String stateId = "";
      String sourceCode = await _appPreferences.getSourceCode();
      String deviceType = Platform.isIOS?"IOS":"Android";
      if(stateModel != null){
        stateId = stateModel.stateId!;

      }else{
        stateId ="";
      }
      if(storeCode.isEmpty){
        storeCode = "";
      }
      // its connected to internet, its safe to call API
  CountryModel?    mCountryModel = await GetIt.I<AppPreferences>().getCountry();

  StateModel ?   mStateModel= await GetIt.I<AppPreferences>().getState();

   CityModel  ? mCityModel= await GetIt.I<AppPreferences>().getCity();

      try {
        List<Map<String,dynamic>>customAttributes = [];
        Map<String,dynamic> phoneMap = {};
        phoneMap['attribute_code'] = 'mobile_number';
        phoneMap['value']= phoneNumber;
        customAttributes.add(phoneMap);
        Map<String,dynamic> countryMap = {};
        countryMap['attribute_code'] = 'default_country';
        countryMap['value']= countryCode;
        customAttributes.add(countryMap);
        Map<String,dynamic> stateMap = {};
        stateMap['attribute_code'] = 'default_state';
        stateMap['value']= stateId;
        customAttributes.add(stateMap);
        //
        Map<String,dynamic> map ={};
        map['email'] = email;
        map['firstname'] = firstName;
        map['lastname'] = lastName;
        map['custom_attributes']= customAttributes;
        Map<String,dynamic> addressMap ={};
        addressMap['firstname'] = firstName;
        addressMap['lastname'] = lastName;
        Map<String,dynamic> regionMap ={};
        regionMap['region_code']=mStateModel == null?"":mStateModel.name;
        regionMap['region']=mStateModel == null?"":mStateModel.name;
        regionMap['region_id']=mStateModel == null?"":mStateModel.stateId;
        addressMap['region'] = regionMap;

        addressMap['country_id'] = mCountryModel == null?"":mCountryModel.id;
        addressMap['city'] = mCityModel == null?"":mCityModel.cityName;
        List<Map<String,dynamic>>addresses = [];
        addresses.add(addressMap);

        Map<String,dynamic> postMap ={};
        postMap['customer'] = map;
        // postMap['addresses']=addresses;
        postMap['password'] = password;
        // postMap['telephone'] = phoneNumber;
        print("postMap ---> ${postMap}");




        final response = await _remoteDataSource.register(postMap,authorization,
            stateId, storeCode, deviceType,sourceCode);

        print("res---> ${response}");

        if (response.response.statusCode == 200) {

          RegisterModel registerModel = response.data .toDomain();

          // success
          // return either right
          // return data
          return Right(registerModel);
        } else  {
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ));
        }
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> forgetPassword(String email,String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
        String stateId = "";
        String deviceType = Platform.isIOS?"IOS":"Android";
        String sourceCode = await _appPreferences.getSourceCode();
        if(stateModel != null){
          stateId = stateModel.stateId!;

        }else{
          stateId ="";
        }
        if(storeCode.isEmpty){
          storeCode = "";
        }
        Map<String,dynamic> map ={};
        map['email'] = email;
        map['template'] = 'email_reset';

        final response = await _remoteDataSource.forgetPasswor(map,authorization,
            stateId, storeCode, deviceType,sourceCode);

        print("res---> ${response}");

        if (response.response.statusCode == 200) {

          // success
          // return either right
          // return data
          return Right(response.data);
        } else  {
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ));
        }
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> category(String authorization)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        final response = await _remoteDataSource.category(authorization,
            stateId, storeCode, deviceType,sourceCode);


        if (response.response.statusCode == 200) {
          // success
          // return either right
          // return data
          return Right(response.data.toDomain());
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              AppStrings.noCategoriesFound.tr()));
        }
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ProductsModel>> getProductsByCategory(Map<String,dynamic> map,String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        final response = await _remoteDataSource.getProductsByCategory(map,authorization,
            stateId, storeCode, deviceType,sourceCode);


        if (response.data.items!.isNotEmpty) {
          // success
          ProductsModel productsModel = response.data.toDomain();
          // return either right
          // return data
          return Right(productsModel);
        } else {

          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              AppStrings.noProductFound.tr()));
        }
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, StockModel>> getStockInfo(String sku,String authorization)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        final response = await _remoteDataSource.getStockInfo(sku,authorization,
            stateId, storeCode, deviceType,sourceCode);


        // if (response.) {
          // success
          // return either right
          // return data
          return Right(response.data.toDomain());

      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserInfoModel>> userInfo(String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        final response = await _remoteDataSource.userInfo(authorization,
            stateId, storeCode, deviceType,sourceCode);


        // if (response.) {
        // success
        // return either right
        // return data
        return Right(response.data.toDomain());

      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateProfile(String email, String password, String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        Map<String,dynamic> map ={};
        map['new_email'] = email;
        map['current_password'] = password;
        final response = await _remoteDataSource.updateProfile(map,authorization,
            stateId, storeCode, deviceType,sourceCode);

        print("res---> ${response}");

        if (response.data) {


          // success
          // return either right
          // return data
          return Right(response.data );
        } else  {
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updatePassword(String newPassword, String confirmNewPassword, String currentPassword, String authorization)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        Map<String,dynamic> map ={};
        map['new_password'] = newPassword;
        map['confirm_password'] = confirmNewPassword;
        map['current_password'] = currentPassword;
        final response = await _remoteDataSource.updatePassword(map,authorization,
            stateId, storeCode, deviceType,sourceCode);

        print("res---> ${response}");

        if (response.data) {


          // success
          // return either right
          // return data
          return Right(response.data );
        } else  {
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, OrderModel>> cart(String authorization)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        final response = await _remoteDataSource.cart(authorization,
            stateId, storeCode, deviceType,sourceCode);


        return Right(response.data.toDomain());
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, AddToCartModel>> addToCart(Map<String, dynamic> map, String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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

        final response = await _remoteDataSource.addToCart(map,authorization,
            stateId, storeCode, deviceType,sourceCode);

        print("res---> ${response}");
        if(response.response.statusCode == 200){
              AddToCartModel addToCartModel = response.data.toDomain();
          return Right(addToCartModel);
        }else{
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ?? ResponseMessage.DEFAULT));
        }


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteItemCart(int itemId, String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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

        final response = await _remoteDataSource.deleteItemCart(itemId,authorization,
            stateId, storeCode, deviceType,sourceCode);

        print("deleteItem---> ${response}");

        if (response.response.statusCode == 200) {
          print(response);

          // success
          // return either right
          // return data
          return Right(response.data);
        } else  {
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ));
        }
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, AddToCartModel>> updateCart(int itemId, Map<String, dynamic> map, String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String language = await _appPreferences.getAppLanguage();
        String sourceCode = await _appPreferences.getSourceCode();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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
        final response = await _remoteDataSource.updateCart(itemId,map,authorization,
            stateId, storeCode, deviceType,sourceCode);

        print("res---> ${response}");
        if(response.response.statusCode == 200){
               AddToCartModel addToCartModel = response.data.toDomain();
          return Right(addToCartModel);
        }else{
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ?? ResponseMessage.DEFAULT));
        }


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, CustomerDomain>> addresses(String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        final response = await _remoteDataSource.addresses(authorization,
            stateId, storeCode, deviceType,sourceCode);


          return Right(response.data.toDomain());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<CountryModel>>> countries(String authorization)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String sourceCode = await _appPreferences.getSourceCode();
        String storeCode= await _appPreferences.getStoreCode();
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
        final response = await _remoteDataSource.countries(authorization,
            stateId, storeCode, deviceType,sourceCode);
        // List<CountryModel> get items {
        //   return (response
        //       ?.map((childResponse) => childResponse.toDomain()) ??
        //       const Iterable.empty())
        //       .cast<CountryModel>()
        //       .toList();
        //
        // }
        Iterable<CountryModel> countries = response.data.map((childResponse) => childResponse.toDomain()).cast<CountryModel>()
        .toList();


        return Right(countries.toList());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> applyCoupon(String coupon, String authorization)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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

        final response = await _remoteDataSource.applyCoupoun(coupon,authorization,
            stateId, storeCode, deviceType,sourceCode);

        print("res---> ${response}");

        if (response.response.statusCode == 200) {

          // success
          // return either right
          // return data
          return Right(response.data);
        } else  {
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ));
        }
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<EstimateShippingMethod>>> estimateShippingMethods(Map<String, dynamic> map, String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        final response = await _remoteDataSource.estimateShippingMethods(map,authorization,
            stateId, storeCode, deviceType,sourceCode);
        // List<CountryModel> get items {
        //   return (response
        //       ?.map((childResponse) => childResponse.toDomain()) ??
        //       const Iterable.empty())
        //       .cast<CountryModel>()
        //       .toList();
        //
        // }
        Iterable<EstimateShippingMethod> estimateList = response.data.map((childResponse) => childResponse.toDomain()).cast<EstimateShippingMethod>()
            .toList();


        return Right(estimateList.toList());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<PaymentMethodModel>>> paymentMethods(String authorization)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        final response = await _remoteDataSource.paymentMethods(authorization,
            stateId, storeCode, deviceType,sourceCode);
        // List<CountryModel> get items {
        //   return (response
        //       ?.map((childResponse) => childResponse.toDomain()) ??
        //       const Iterable.empty())
        //       .cast<CountryModel>()
        //       .toList();
        //
        // }
        Iterable<PaymentMethodModel> estimateList = response.data.map((childResponse) => childResponse.toDomain()).cast<PaymentMethodModel>()
            .toList();


        return Right(estimateList.toList());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, WishListModel>> wishList(String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        final response = await _remoteDataSource.wishList(authorization,
            stateId, storeCode, deviceType,sourceCode);
        if(response.data.wishList!.isNotEmpty) {
          return Right(response.data.toDomain());
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE,AppStrings.wishListEmpty.tr()));
        }


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, RemoveWishListModel>> removeWishItemList(String authorization, String id) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        final response = await _remoteDataSource.removeItemWishList(authorization,id,
            stateId, storeCode, deviceType,sourceCode);
        if(response.response.statusCode== 200) {

          RemoveWishListModel removeWishListModel = response.data.toDomain();
          return Right(removeWishListModel);
        }else{
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          return Left(Failure(ApiInternalStatus.FAILURE,errorModel.message));
        }


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, AddItemToWishListModel>> addItemToWishItemList(String authorization, String id)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        final response = await _remoteDataSource.addItemWishList(authorization,id,
            stateId, storeCode, deviceType,sourceCode);
        if(response.response.statusCode== 200) {

          AddItemToWishListModel removeWishListModel = response.data.toDomain();
          return Right(removeWishListModel);
        }else{
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          return Left(Failure(ApiInternalStatus.FAILURE,errorModel.message));
        }


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> contactUs(Map<String, dynamic> map)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        final response = await _remoteDataSource.contactUs(map,
            stateId, storeCode, deviceType,sourceCode);
        if(response.response.statusCode== 200) {


          return Right(response.data);
        }else{
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          return Left(Failure(ApiInternalStatus.FAILURE,errorModel.message));
        }


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAccount(int userId, String authorization)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        final response = await _remoteDataSource.deleteAccount(userId,authorization,
            stateId, storeCode, deviceType,sourceCode);
        if(response.response.statusCode== 200) {
          final responseData = response.data ;

          return Right(responseData);
        }else{
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          return Left(Failure(ApiInternalStatus.FAILURE,errorModel.message));
        }


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<CityModel>>> cities(String stateName)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        final response = await _remoteDataSource.cities(stateName,
            stateId, storeCode, deviceType,sourceCode);
        // List<CountryModel> get items {
        //   return (response
        //       ?.map((childResponse) => childResponse.toDomain()) ??
        //       const Iterable.empty())
        //       .cast<CountryModel>()
        //       .toList();
        //
        // }
        Iterable<CityModel> cityList = response.data.map((childResponse) => childResponse.toDomain()).cast<CityModel>()
            .toList();


        return Right(cityList.toList());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<StateModel>>> states(String countryCode) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        final response = await _remoteDataSource.states(countryCode,
            stateId, storeCode, deviceType,sourceCode);
        // List<CountryModel> get items {
        //   return (response
        //       ?.map((childResponse) => childResponse.toDomain()) ??
        //       const Iterable.empty())
        //       .cast<CountryModel>()
        //       .toList();
        //
        // }
        Iterable<StateModel> statesList = response.data.map((childResponse) => childResponse.toDomain()).cast<StateModel>()
            .toList();


        return Right(statesList.toList());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, CustomerDomain>> addAddress(Map<String, dynamic> map, String authorization)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
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
        final response = await _remoteDataSource.addAddress(map,authorization,
            stateId, storeCode, deviceType,sourceCode);


        return Right(response.data.toDomain());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAddress(int itemId, String authorization)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String sourceCode = await _appPreferences.getSourceCode();
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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

        final response = await _remoteDataSource.deleteAddress(itemId,authorization,
            stateId, storeCode, deviceType,sourceCode);

        print("res---> ${response}");

        if (response.response.statusCode == 200) {

          // success
          // return either right
          // return data
          return Right(response.data );
        } else  {
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ));
        }
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ShippingInformationModel>> shippingInformation(Map<String, dynamic> map, String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String language = await _appPreferences.getAppLanguage();
        String sourceCode = await _appPreferences.getSourceCode();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
        print("sourceCode ---> ${storeCode}");
        print("map Shippping information ---> ${map}");
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
        final response = await _remoteDataSource.shippingInformation(map,authorization,
            stateId, storeCode, deviceType,sourceCode);
        print("shipping information Response ---> ${response.data}");
        if(response.response.statusCode == 200){
          // final shippingInformationResponse =ShippingInformationResponse.fromJson(response.data as Map<String, dynamic>);
          ShippingInformationModel shippingInformationModel = response.data.toDomain();
          return Right(shippingInformationModel);
        }else{
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ));
        }





      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, CheckOutModel>> checkout(String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String sourceCode = await _appPreferences.getSourceCode();
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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
        final response = await _remoteDataSource.checkOut(authorization,
            stateId, storeCode, deviceType,sourceCode);


        return Right(response.data.toDomain());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCouponCode(String authorization)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String sourceCode = await _appPreferences.getSourceCode();
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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

        final response = await _remoteDataSource.deleteCoupounCode(authorization,
            stateId, storeCode, deviceType,sourceCode);

        print("res---> ${response}");

        if (response.response.statusCode == 200) {

          // success
          // return either right
          // return data
          return Right(response.data );
        } else  {
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ));
        }
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, MyOrdersModel>> getMyOrders(Map<String, dynamic> map, String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String sourceCode = await _appPreferences.getSourceCode();
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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

        final response = await _remoteDataSource.getMyOrders(map,authorization,
            stateId, storeCode, deviceType,sourceCode);

        print("res---> ${response}");

        if (response.response.statusCode == 200) {

          MyOrdersModel myOrdersModel = response.data.toDomain();
          // success
          // return either right
          // return data
          return Right(myOrdersModel);
        } else  {
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ));
        }
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> cancelOrder(String orderId, String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String sourceCode = await _appPreferences.getSourceCode();
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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

        final response = await _remoteDataSource.cancelOrder(orderId,authorization,
            stateId, storeCode, deviceType,sourceCode);

        print("res---> ${response}");

        if (response.response.statusCode == 200) {

          // success
          // return either right
          // return data
          return Right(response.data );
        } else  {
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ));
        }
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, AppVersionModel>> appVersions(String authorization)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String sourceCode = await _appPreferences.getSourceCode();
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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
        final response = await _remoteDataSource.appVersions(authorization,
            stateId, storeCode, deviceType,sourceCode);
        // List<CountryModel> get items {
        //   return (response
        //       ?.map((childResponse) => childResponse.toDomain()) ??
        //       const Iterable.empty())
        //       .cast<CountryModel>()
        //       .toList();
        //
        // }



        return Right(response.data.toDomain());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ContactUsModel>> contactusDetails(String authorization)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String sourceCode = await _appPreferences.getSourceCode();
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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
        final response = await _remoteDataSource.getContactUs(authorization,
            stateId, storeCode, deviceType,sourceCode);
        // List<CountryModel> get items {
        //   return (response
        //       ?.map((childResponse) => childResponse.toDomain()) ??
        //       const Iterable.empty())
        //       .cast<CountryModel>()
        //       .toList();
        //
        // }



        return Right(response.data.toDomain());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ScreenHome>> getHome(String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String sourceCode = await _appPreferences.getSourceCode();
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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
        final response = await _remoteDataSource.getHome(authorization,
            stateId, storeCode, deviceType,sourceCode);




        return Right(response.data.toDomain());


      } catch (error) {
        print(error);
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }


  @override
  Future<Either<Failure, List<BrandsDataModel>>> getBrands(String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String sourceCode = await _appPreferences.getSourceCode();
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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
        final response = await _remoteDataSource.getBrands(authorization,
            stateId, storeCode, deviceType,sourceCode);
        // List<CountryModel> get items {
        //   return (response
        //       ?.map((childResponse) => childResponse.toDomain()) ??
        //       const Iterable.empty())
        //       .cast<CountryModel>()
        //       .toList();
        //
        // }
        Iterable<BrandsDataModel> brandsList = response.data.map((childResponse) => childResponse.toDomain()).cast<BrandsDataModel>()
            .toList();


        return Right(brandsList.toList());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> generateInvoice(String authoriztion, String invoiceValue, String customerName, String countryCode)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String sourceCode = await _appPreferences.getSourceCode();
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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

        final response = await _remoteDataSource.generateInvoice(authoriztion,invoiceValue,customerName,countryCode,
            stateId, storeCode, deviceType,sourceCode);

        print("res---> ${response.data}");

        if (response.response.statusCode == 200) {
;


          // success
          // return either right
          // return data
          return Right(response.data);
        } else  {
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ));
        }
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, int>> order(Map<String, dynamic> map, String authorization)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String sourceCode = await _appPreferences.getSourceCode();
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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

        final response = await _remoteDataSource.order(map,authorization,
            stateId, storeCode, deviceType,sourceCode);

        print("res---> ${response}");

        if (response.response.statusCode == 200) {

          // return either right
          // return data
          return Right(response.data);
        } else  {
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ));
        }
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, int>> createCart(String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String sourceCode = await _appPreferences.getSourceCode();
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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

        final response = await _remoteDataSource.createCart(authorization,
            stateId, storeCode, deviceType,sourceCode);

        print("res---> ${response}");

        if (response.response.statusCode == 200) {

          // return either right
          // return data
          return Right(response.data);
        } else  {
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ));
        }
      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }

      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, StoreLocatorModel>> storeLocator(String authorization, String country, String state) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String sourceCode = await _appPreferences.getSourceCode();
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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
        final response = await _remoteDataSource.storeLocator(authorization,country,state,
            stateId, storeCode, deviceType,sourceCode);
        // List<CountryModel> get items {
        //   return (response
        //       ?.map((childResponse) => childResponse.toDomain()) ??
        //       const Iterable.empty())
        //       .cast<CountryModel>()
        //       .toList();
        //
        // }



        return Right(response.data.toDomain());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, PromoModel>> promo(String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String sourceCode = await _appPreferences.getSourceCode();
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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
        final response = await _remoteDataSource.promo(authorization,
            stateId, storeCode, deviceType,sourceCode);
      



        return Right(response.data.toDomain());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, NewLoginModel>> newLogin(Map<String, dynamic> map, String authorization) async {
    if (!await _networkInfo.isConnected) {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

    try {
      final sourceCode = await _appPreferences.getSourceCode();
      final language = await _appPreferences.getAppLanguage();
      final stateModel = await _appPreferences.getState();
      final storeCode = await _appPreferences.getStoreCode();
      final deviceType = Platform.isIOS ? "IOS" : "Android";
      final stateId = stateModel?.stateId ?? "";

      final response = await _remoteDataSource.newLogin(
        map,
        authorization,
        stateId,
        storeCode.isEmpty ? "" : storeCode,
        deviceType,
        sourceCode,
      );

      print("res---> ${response}");

      final responseData = response.response.data;
      if (responseData is Map<String, dynamic> && responseData.containsKey("token")) {
        final newLoginModel = response.data.toDomain();
        return Right(newLoginModel);
      } else {
        final errorData = ErrorResponse.fromJson(responseData);
        final errorModel = errorData.toDomain();

        return Left(Failure(
          ApiInternalStatus.FAILURE,
          errorModel.message ?? ResponseMessage.DEFAULT,
        ));
      }
    } catch (error) {
      if (error is DioException) {
        final data = error.response?.data;
        if (data is Map<String, dynamic>) {
          try {
            final errorData = ErrorResponse.fromJson(data);
            final errorModel = errorData.toDomain();
            return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
          } catch (_) {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
          }
        }
        return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
      }

      return Left(ErrorHandler.handle(error).failure!);
    }
  }

  @override
  Future<Either<Failure, SplashModel>> splash() async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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
        String sourceCode = await _appPreferences.getSourceCode();
        final response = await _remoteDataSource.splash(Constants.headerValue,
            stateId, storeCode, deviceType,sourceCode);




        return Right(response.data.toDomain());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, CheckStockModel>> checkStock(Map<String, dynamic> map,String authorization,)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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
        String sourceCode = await _appPreferences.getSourceCode();
        final response = await _remoteDataSource.checkStock(map,authorization,
            stateId, storeCode, deviceType,sourceCode);




        return Right(response.data.toDomain());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, SortingCategoryModel>> sortingCategory(String authorization, int categoryId)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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
        String sourceCode = await _appPreferences.getSourceCode();
        final response = await _remoteDataSource.sortingCategory(categoryId,authorization,
            stateId, storeCode, deviceType,sourceCode);




        if (response.response.statusCode == 200) {

          SortingCategoryModel registerModel = response.data.toDomain();

          // success
          // return either right
          // return data
          return Right(registerModel);
        } else  {
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ));
        }


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, CategoryHomeModel>> categoryhome(String authorization) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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
        String sourceCode = await _appPreferences.getSourceCode();
        final response = await _remoteDataSource.categoryHome(Constants.headerValue,
            stateId, storeCode, deviceType,sourceCode);




        return Right(response.data.toDomain());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, LocationModel>> saveLocation(Map<String, dynamic> map, String authorization)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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
        String sourceCode = await _appPreferences.getSourceCode();
        final response = await _remoteDataSource.saveLocation(map,authorization,
            stateId, storeCode, deviceType,sourceCode);




        return Right(response.data.toDomain());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> paymentInformation(Map<String, dynamic> map, String authorization)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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
        String sourceCode = await _appPreferences.getSourceCode();
        final response = await _remoteDataSource.setPaymentInformation(map,authorization,
            stateId, storeCode, deviceType,sourceCode);
        print(response.data );





        if (response.response.statusCode == 200) {

          // success
          // return either right
          // return data
          return Right(response.data);
        } else  {
          final errorData = ErrorResponse.fromJson(response.data as Map<String, dynamic>);
          ErrorModel errorModel = errorData.toDomain();
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              errorModel.message ));
        }


      } catch (error) {

        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, TimeLine>> timeLine(String authorization, String orderId) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String sourceCode = await _appPreferences.getSourceCode();
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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
        final response = await _remoteDataSource.timeLine(authorization,
            stateId, storeCode, deviceType,sourceCode,orderId);




        return Right(response.data.toDomain());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, RatingModel>> rating(String authorization, Map<String, dynamic> map)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        String sourceCode = await _appPreferences.getSourceCode();
        String language = await _appPreferences.getAppLanguage();
        StateModel? stateModel = await _appPreferences.getState();
        String storeCode= await _appPreferences.getStoreCode();
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
        final response = await _remoteDataSource.rating(authorization,
            stateId, storeCode, deviceType,sourceCode,map);




        return Right(response.data.toDomain());


      } catch (error) {
        if(error is DioException){
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            try {
              final errorData = ErrorResponse.fromJson(data);
              final errorModel = errorData.toDomain();

              return Left(Failure(ApiInternalStatus.FAILURE, errorModel.message));
            } catch (_) {
              return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error structure"));
            }
          } else {
            return Left(Failure(ApiInternalStatus.FAILURE, "Unexpected error format"));
          }
        }else{
          return Left(ErrorHandler.handle(error).failure!);
        }
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }








}