
import 'dart:convert';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/state_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/model/city_model.dart';
import '../presentation/resources/langauge_manager.dart';
const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_USER_ID = "PREFS_KEY_USER_ID";
const String PREFS_KEY_USER_TOKEN = "PREFS_KEY_USER_TOKEN";
const String PREFS_KEY_EMAIL = "PREFS_KEY_EMAIL";
const String PREFS_KEY_PASSWORD = "PREFS_KEY_PASSWORD";
const String PREFS_KEY_COUNTRY_ID="PREFS_KEY_COUNTRY_ID";
const String PREFS_KEY_COUNTRY_CODE="PREFS_KEY_COUNTRY_CODE";
const String PREFS_KEY_CURRENCY_CODE="PREFS_KEY_CURRENCY_CODE";
const String PREFS_KEY_COUNTRY_EN_TITLE="PREFS_KEY_COUNTRY_EN_TITLE";
const String PREFS_KEY_COUNTRY_AR_TITLE="PREFS_KEY_COUNTRY_AR_TITLE";
const String PREFS_KEY_AREA_CODE="PREFS_KEY_AREA_CODE";
const String PREFS_KEY_FLAG="PREFS_KEY_FLAG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED =
    "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_IS_ENABLED = "PREFS_KEY_IS_ENABLED";
const String PREFS_KEY_STORE_CODE="PREFS_KEY_STORE_CODE";
const String PREFS_KEY_SOURCE_CODE="PREFS_KEY_SOURCE_CODE";
const String PREFS_KEY_WEB_SITE_ID="PREFS_KEY_WEB_SITE";
class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    print("mLanguahghe ---> ${language}");
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      // return default lang
      return LanguageType.ENGLISH.getValue();
    }
  }
  Future<int> getUserId() async {
    int? userId = _sharedPreferences.getInt(PREFS_KEY_USER_ID);
    if (userId != null && userId!= 0 ) {
      return userId;
    } else {
      // return default lang
      return 0;
    }
  }
  Future<String> getUserToken() async {
    String? userToken = _sharedPreferences.getString(PREFS_KEY_USER_TOKEN);
    if (userToken != null && userToken!= "" ) {
      return userToken;
    } else {
      // return default lang
      return "";
    }
  }
  Future<void> setUserToken(String userToken) async {

    // set english
    _sharedPreferences.setString(
        PREFS_KEY_USER_TOKEN, userToken);

  }
  Future<String> getStoreCode() async {
    String? storeCode = _sharedPreferences.getString(PREFS_KEY_STORE_CODE);
    if (storeCode != null && storeCode!= "" ) {
      return storeCode;
    } else {
      // return default lang
      return "";
    }
  }
  Future<void> setStoreCode(String storeCode) async {

    // set english
    _sharedPreferences.setString(
        PREFS_KEY_STORE_CODE, storeCode);

  }
  Future<String> getWebSiteId() async {
    String? webSiteId = _sharedPreferences.getString(PREFS_KEY_WEB_SITE_ID);
    if (webSiteId != null && webSiteId!= "" ) {
      return webSiteId;
    } else {
      // return default lang
      return "";
    }
  }
  Future<void> setWebSiteId(String webSiteId) async {

    // set english
    _sharedPreferences.setString(
        PREFS_KEY_WEB_SITE_ID, webSiteId);

  }

  Future<String> getSourceCode() async {
    String? sourceCode = _sharedPreferences.getString(PREFS_KEY_SOURCE_CODE);
    if (sourceCode != null && sourceCode!= "" ) {
      return sourceCode;
    } else {
      // return default lang
      return "";
    }
  }
  Future<void> setSourceCode(String sourceCode) async {
    print("source code ---> $sourceCode");

    // set english
    _sharedPreferences.setString(
        PREFS_KEY_SOURCE_CODE, sourceCode);

  }
  Future<String> getEmail() async {
    String? email = _sharedPreferences.getString(PREFS_KEY_EMAIL);
    if (email != null && email!= "" ) {
      return email;
    } else {
      // return default lang
      return "";
    }
  }

  Future<String> getPassword() async {
    String? password = _sharedPreferences.getString(PREFS_KEY_PASSWORD);
    if (password != null && password!= "" ) {
      return password;
    } else {
      // return default lang
      return "";
    }
  }

  Future<void> setEmail(String email) async {

    // set english
    _sharedPreferences.setString(
        PREFS_KEY_EMAIL, email);

  }
  Future<void> setPassword(String password) async {

    // set english
    _sharedPreferences.setString(
        PREFS_KEY_PASSWORD, password);

  }
  Future<void> setEnabled(bool isEnabled) async {

    // set english
    _sharedPreferences.setBool(
        PREFS_KEY_IS_ENABLED, isEnabled);

  }

  Future<bool> getEnabled() async {
    bool? isEnabled = _sharedPreferences.getBool(PREFS_KEY_IS_ENABLED);
    if (isEnabled != null && isEnabled!= false ) {
      return isEnabled;
    } else {
      // return default lang
      return false;
    }
  }
  Future<void> setUserId(int userId) async {

      // set english
      _sharedPreferences.setInt(
          PREFS_KEY_USER_ID, userId);

  }

  Future<void> changeAppLanguage(BuildContext context) async {
    String currentLang = await getAppLanguage();
    Locale loc;
    if (currentLang == LanguageType.ARABIC.getValue()) {
      // set english
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.ENGLISH.getValue());
     loc = context.supportedLocales[0];
    } else {
      // set arabic
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.ARABIC.getValue());
       loc = context.supportedLocales[1];
    }



    await context.setLocale(loc);




  }



  Future<Locale> getLocal() async {
    String currentLang = await getAppLanguage();

    if (currentLang == LanguageType.ARABIC.getValue()) {
      return ARABIC_LOCAL;
    } else {
      return ENGLISH_LOCAL;
    }
  }

  // on boarding

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED) ??
        false;
  }

  //login

  Future<void> setUserLoggedIn(bool isLoggedIN) async {
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, isLoggedIN);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
  }

  static const String cityKey = "selected_city";
  static const String stateKey = "selected_state";
  static const String countryKey = "selected_country";
  /// Save CityModel
   Future<void> saveCity(CityModel city) async {
    final prefs = await SharedPreferences.getInstance();
    final cityJson = jsonEncode(city.toJson()); // Convert model to JSON
    await prefs.setString(cityKey, cityJson);
  }

  /// Get CityModel
   Future<CityModel?> getCity() async {
    final prefs = await SharedPreferences.getInstance();
    final cityJson = prefs.getString(cityKey);

    if (cityJson == null) return null;

    return CityModel.fromJson(jsonDecode(cityJson)); // Convert JSON to model
  }

  /// Remove CityModel
   Future<void> removeCity() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cityKey);
  }


  /// Save CityModel
   Future<void> saveState(StateModel state) async {
    final prefs = await SharedPreferences.getInstance();
    final stateJson = jsonEncode(state.toJson()); // Convert model to JSON
    await prefs.setString(stateKey, stateJson);
  }

  /// Get CityModel
   Future<StateModel?> getState() async {
    final prefs = await SharedPreferences.getInstance();
    final stateJson = prefs.getString(stateKey);

    if (stateJson == null) return null;

    return StateModel.fromJson(jsonDecode(stateJson)); // Convert JSON to model
  }

  /// Remove CityModel
   Future<void> removeState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(stateKey);
  }

  /// Save CityModel
   Future<void> saveCountry(CountryModel countryModel) async {
    final prefs = await SharedPreferences.getInstance();
    final countryJson = jsonEncode(countryModel.toJson()); // Convert model to JSON
    await prefs.setString(countryKey, countryJson);
  }

  /// Get CityModel
   Future<CountryModel?> getCountry() async {
    final prefs = await SharedPreferences.getInstance();
    final countryJson = prefs.getString(countryKey);

    if (countryJson == null) return null;

    return CountryModel.fromJson(jsonDecode(countryJson)); // Convert JSON to model
  }

  /// Remove CityModel
   Future<void> removeCountry() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(countryKey);
  }
}