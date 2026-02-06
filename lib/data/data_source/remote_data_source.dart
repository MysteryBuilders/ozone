





import 'package:ozon/app/app_prefrences.dart';

import 'package:ozon/data/request/user_model.dart';
import 'package:ozon/data/response/address_response.dart';
import 'package:ozon/data/response/app_version_response.dart';
import 'package:ozon/data/response/category_home_response.dart';
import 'package:ozon/data/response/category_response.dart';
import 'package:ozon/data/response/check_out_response.dart';
import 'package:ozon/data/response/check_stock_response.dart';
import 'package:ozon/data/response/city_response.dart';
import 'package:ozon/data/response/contact_us_response.dart';
import 'package:ozon/data/response/countries_response.dart';
import 'package:ozon/data/response/estimate_shipping_method_response.dart';
import 'package:ozon/data/response/home_screen_response.dart';
import 'package:ozon/data/response/location_response.dart';
import 'package:ozon/data/response/order_response.dart';
import 'package:ozon/data/response/payment_method_response.dart';

import 'package:ozon/data/response/products_response.dart';
import 'package:ozon/data/response/promo_response.dart';
import 'package:ozon/data/response/rating_response.dart';
import 'package:ozon/data/response/register_response.dart';
import 'package:ozon/data/response/remove_wish_list_response.dart';
import 'package:ozon/data/response/shipping_information_response.dart';
import 'package:ozon/data/response/splash_response.dart';
import 'package:ozon/data/response/state_response.dart';
import 'package:ozon/data/response/stock_response.dart';
import 'package:ozon/data/response/time_line_response.dart';
import 'package:ozon/data/response/user_info_response.dart';
import 'package:ozon/data/response/wish_list_response.dart';
import 'package:retrofit/retrofit.dart';


import '../network/app_api.dart';

import '../response/add_to_cart_response.dart';
import '../response/add_to_wish_list_response.dart';
import '../response/brands_response.dart';
import '../response/generate_invoice_response.dart';
import '../response/my_orders_response.dart';
import '../response/new_login_response.dart';
import '../response/screen_parser.dart';
import '../response/sorting_category_response.dart';
import '../response/state_locator_response.dart';
import '../response/version_response.dart';
import 'package:retrofit/http.dart';

abstract class RemoteDataSource {

  Future<HttpResponse<VersionResponse>> version(String Authorization,String stateId,
      String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<CategoryHomeResponse>> categoryHome(String Authorization,String stateId,
      String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<SplashResponse>> splash(String Authorization,String stateId,
      String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<PromoResponse>> promo(String authoriztion,
      String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<dynamic>> generateInvoice(String authoriztion,String invoiceValue,String customerName,String countryCode,
      String stateId, String storeCode,String deviceType,String sourceCode);

  Future<HttpResponse<bool>> updatePassword(Map<String, dynamic> body,String authoriztion,
      String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<bool>> updateProfile(Map<String, dynamic> body,String authoriztion,
      String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<String>> login(Map<String, dynamic> body,String authoriztion,
      String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<RegisterResponse>> register(Map<String, dynamic> body,String authoriztion,
      String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<AddToCartResponse>> updateCart(int itemId,Map<String, dynamic> body,String authoriztion,
      String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<AddToCartResponse>> addToCart(Map<String, dynamic> body,String authoriztion,
      String stateId, String storeCode,String deviceType,String sourceCode);

  Future<HttpResponse<bool>> setPaymentInformation(Map<String, dynamic> body,String authoriztion,
      String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<bool>> forgetPasswor(Map<String, dynamic> body,String authoriztion,
      String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<bool>> deleteItemCart(int itemId,String authoriztion,
      String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<bool>> deleteAddress(int itemId,String authoriztion,
      String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<SortingCategoryResponse>> sortingCategory(int categoryId,String authoriztion,
      String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<CategoryResponse>> category(String authoriztion,
      String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<CheckOutResponse>> checkOut(String authoriztion,
      String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<UserInfoResponse>> userInfo(String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<OrderResponse>> cart(String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<int>> createCart(String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<AddressesResponse>> addresses(String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<StareLocatorResponse>> storeLocator(String authoriztion,String country,String state, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<AddressesResponse>> addAddress(Map<String,dynamic> map,String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<ShippingInformationResponse>> shippingInformation(Map<String,dynamic> map,String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<NewLoginResponse>> newLogin(Map<String,dynamic> map,String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<List<CountryResponse>>> countries(String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<List<PaymentMethodResponse>>> paymentMethods(String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<List<EstimateShippingMethodResponse>>> estimateShippingMethods(Map<String,dynamic> map,String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<ProductsResponse>> getProductsByCategory(Map<String,dynamic> map,String authoriztion,
      String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<StockResponse>> getStockInfo(String sku,String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<bool>> applyCoupoun(String coupon,String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<WishListResponse>> wishList(String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<RemoveWishListResponse>> removeItemWishList(String authoriztion,String id, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<AddToWishListResponse>> addItemWishList(String authoriztion,String id, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<bool>> deleteAccount(int userId,String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<dynamic>> contactUs(Map<String,dynamic> map, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<List<StateResponse>>> states(String countryCode, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<List<CityResponse>>> cities(String stateName, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<bool>> deleteCoupounCode(String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<MyOrdersResponse>> getMyOrders(Map<String,dynamic> map,String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<bool>> cancelOrder(String orderId,String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<AppVersionResponse> >appVersions(String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<ContactUsResponse>> getContactUs(String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<Screen>> getHome(String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<TimeLineResponse>> timeLine(String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode,String orderId);
  Future<HttpResponse<List<BrandsDataResponse>>> getBrands(String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<int>> order(Map<String, dynamic> body,String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<CheckStockResponse>> checkStock(Map<String, dynamic> body,String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<LocationResponse>> saveLocation(Map<String,dynamic> map, String Authorization,String stateId, String storeCode,String deviceType,String sourceCode);
  Future<HttpResponse<RatringResponse>> rating(String authoriztion, String stateId, String storeCode,String deviceType,String sourceCode,Map<String,dynamic> map);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  final AppPreferences _appPreferences;


  RemoteDataSourceImpl(this._appServiceClient,this._appPreferences);



  @override
  Future<HttpResponse<VersionResponse>> version(String Authorization,String stateId,
      String storeCode,String deviceType,String sourceCode) async{
    return await _appServiceClient.version(Authorization,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode
    );
  }

  @override
  Future<HttpResponse<String>> login(Map<String, dynamic> body,String authoriztion,
   String stateId, String storeCode,String deviceType,String sourceCode
      ) async{
    return await _appServiceClient.login(body,authoriztion,
        stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<RegisterResponse>> register(Map<String, dynamic> body,String authoriztion,
      String stateId, String storeCode,String deviceType,String sourceCode)async {
    return await _appServiceClient.register(body,authoriztion,
        stateId,storeCode,deviceType,sourceCode,storeCode,storeCode
    );
  }

  @override
  Future<HttpResponse<bool>> forgetPasswor(Map<String, dynamic> body,String authoriztion,
      String stateId, String storeCode,String deviceType,String sourceCode)async {
    return await _appServiceClient.forgetPassword(body,authoriztion,
        stateId,storeCode,deviceType,sourceCode,storeCode,storeCode
    );
  }

  @override
  Future<HttpResponse<CategoryResponse>> category(String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode) async{
    return await _appServiceClient.categories(authoriztion,
        stateId,storeCode,deviceType,sourceCode,storeCode,storeCode
    );
  }

  @override
  Future<HttpResponse<ProductsResponse>> getProductsByCategory(Map<String,dynamic> map,String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode) async{
    return await _appServiceClient.getProductsByCategory(map,authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode
    );
  }

  @override
  Future<HttpResponse<StockResponse>> getStockInfo(String sku,String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
    return await _appServiceClient.getStockInfo(sku,authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode
    );
  }

  @override
  Future<HttpResponse<UserInfoResponse>> userInfo(String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
    // TODO: implement userInfo
    return await _appServiceClient.userInfo(authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode
    );
  }

  @override
  Future<HttpResponse<bool>> updateProfile(Map<String, dynamic> body, String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
    return await _appServiceClient.updateProfile(body,authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<bool>> updatePassword(Map<String, dynamic> body, String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
    return await _appServiceClient.updatePassword(body,authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<OrderResponse>> cart(String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
    return await _appServiceClient.cart(authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<AddToCartResponse>> addToCart(Map<String, dynamic> body, String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
    return await _appServiceClient.addToCart(body,authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<bool>> deleteItemCart(int itemId, String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
    return await _appServiceClient.deleteItemCart(itemId,authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<AddToCartResponse>> updateCart(int itemId, Map<String, dynamic> body, String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
    return await _appServiceClient.updateCart(itemId,body,authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<AddressesResponse>> addresses(String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode) async{
return await _appServiceClient.getAddresses(authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<List<CountryResponse>>> countries(String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode) async{
    return await _appServiceClient.countries(authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<List<EstimateShippingMethodResponse>>> estimateShippingMethods(Map<String,dynamic> map,String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
    // TODO: implement estimateShippingMethods
    return await _appServiceClient.estimateShippingMethods(map, authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<bool>> applyCoupoun(String coupon, String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode) async{
    // TODO: implement applyCoupoun
  return await _appServiceClient.applyCoupon(coupon, authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<List<PaymentMethodResponse>>> paymentMethods(String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode) async{
    return await _appServiceClient.paymentMethods( authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<WishListResponse>> wishList(String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
    return await _appServiceClient.wishList( authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<RemoveWishListResponse>> removeItemWishList(String authoriztion, String id,String stateId, String storeCode,String deviceType,String sourceCode)async {
    return await _appServiceClient.removeItemWishList( authoriztion,id,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<AddToWishListResponse>> addItemWishList(String authoriztion, String id,String stateId, String storeCode,String deviceType,String sourceCode) async{
    return await _appServiceClient.AddItemWishList( authoriztion,id,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<dynamic>> contactUs(Map<String, dynamic> map,String stateId, String storeCode,String deviceType,String sourceCode) async{
    return await _appServiceClient.contactUs(map,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<bool>> deleteAccount(int userId,String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode) async{
    // TODO: implement deleteAccount
 return await _appServiceClient.deleteUserAccount(userId, authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<List<CityResponse>>> cities(String stateName,String stateId, String storeCode,String deviceType,String sourceCode) async{
return await _appServiceClient.cities(stateName,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<List<StateResponse>>> states(String countryCode,String stateId, String storeCode,String deviceType,String sourceCode)async {
    return await _appServiceClient.states(countryCode,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<AddressesResponse>> addAddress(Map<String, dynamic> map, String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
    return await _appServiceClient.addAddress(map,authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<bool>> deleteAddress(int itemId, String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode) async{
    return await _appServiceClient.deleteAddress(itemId,authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<ShippingInformationResponse>> shippingInformation(Map<String, dynamic> map, String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
 return await _appServiceClient.shippingInformation(map, authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<CheckOutResponse>> checkOut(String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode) async{
    return await _appServiceClient.checkout( authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<bool>> deleteCoupounCode(String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
 return await _appServiceClient.deleteCoupoun(authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<MyOrdersResponse>> getMyOrders(Map<String, dynamic> map, String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
    return await _appServiceClient.orders(map,authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<bool>> cancelOrder(String orderId, String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode) async{
 return await _appServiceClient.cancelOrder(orderId, authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<AppVersionResponse>> appVersions(String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
 return await _appServiceClient.appVersions(authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<ContactUsResponse>> getContactUs(String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
    return await _appServiceClient.conactUsDetails(authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<Screen>> getHome(String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode) async{
    final response = await _appServiceClient.home(
      authoriztion,
      stateId,
      storeCode,
      deviceType,
      sourceCode,
      storeCode, // store
      storeCode, // storeId
    );

    final parsedScreen = parseScreen(response.data);

    return HttpResponse(parsedScreen, response.response);
  }

  @override
  Future<HttpResponse<List<BrandsDataResponse>>> getBrands(String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
    return await _appServiceClient.brands(authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<dynamic>> generateInvoice(String authoriztion, String invoiceValue, String customerName, String countryCode,String stateId, String storeCode,String deviceType,String sourceCode) async{
   return await _appServiceClient.generateInvoice(authoriztion, invoiceValue, customerName, countryCode,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<int>> order(Map<String, dynamic> body, String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode) async{
 return await _appServiceClient.order(body, authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<int>> createCart(String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
  return await _appServiceClient.createCart(authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<StareLocatorResponse>> storeLocator(String authoriztion, String country, String state,String stateId, String storeCode,String deviceType,String sourceCode)async {
return await _appServiceClient.storeLocator(authoriztion, country, state,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<PromoResponse>> promo(String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode) async{
  return await _appServiceClient.promo(authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<NewLoginResponse>> newLogin(Map<String, dynamic> map, String authoriztion,String stateId, String storeCode,String deviceType,String sourceCode)async {
    return await _appServiceClient.newLogin(map,authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<SplashResponse>> splash(String Authorization, String stateId, String storeCode, String deviceType,String sourceCode) async{
    return await _appServiceClient.splash(Authorization,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<CheckStockResponse>> checkStock(Map<String, dynamic> body, String authoriztion, String stateId, String storeCode, String deviceType,String sourceCode) async{
    return await _appServiceClient.checkStockItems(body,authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<SortingCategoryResponse>> sortingCategory(int categoryId, String authoriztion, String stateId, String storeCode, String deviceType,String sourceCode)async {
    return await _appServiceClient.sortingCategory(categoryId,authoriztion,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<CategoryHomeResponse>> categoryHome(String Authorization, String stateId, String storeCode, String deviceType,String sourceCode) async{
    return await _appServiceClient.getCategoryHome(Authorization,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<LocationResponse>> saveLocation(Map<String, dynamic> map, String Authorization,String stateId, String storeCode, String deviceType, String sourceCode) async{
    return await _appServiceClient.location(map,Authorization,stateId,storeCode,deviceType,sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<bool>> setPaymentInformation(Map<String, dynamic> body, String authoriztion, String stateId, String storeCode, String deviceType, String sourceCode) async{
  return await _appServiceClient.setPaymentInformation(body, authoriztion, stateId, storeCode, deviceType, sourceCode,storeCode,storeCode);
  }

  @override
  Future<HttpResponse<TimeLineResponse>> timeLine(String authoriztion, String stateId, String storeCode, String deviceType, String sourceCode, String orderId)async {
    return await _appServiceClient.timeLine(
      authoriztion,
      stateId,
      storeCode,
      deviceType,
      sourceCode,
      storeCode, // store
      storeCode,
      orderId// storeId
    );
  }

  @override
  Future<HttpResponse<RatringResponse>> rating(String authoriztion, String stateId, String storeCode, String deviceType, String sourceCode, Map<String, dynamic> map) async{
  return await _appServiceClient.rating(authoriztion, stateId,storeCode,deviceType,sourceCode,storeCode,storeCode,map);
  }






}
