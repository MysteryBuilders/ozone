import 'dart:io';
import 'package:ozon/data/response/products_response.dart';
import 'package:ozon/data/response/rating_response.dart';
import 'package:ozon/data/response/time_line_response.dart';
import 'package:ozon/presentation/leave_review/view/leave_review_view.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ozon/data/response/address_response.dart';
import 'package:ozon/data/response/app_version_response.dart';
import 'package:ozon/data/response/category_home_response.dart';
import 'package:ozon/data/response/category_response.dart';
import 'package:ozon/data/response/check_out_response.dart';
import 'package:ozon/data/response/city_response.dart';
import 'package:ozon/data/response/contact_us_response.dart';
import 'package:ozon/data/response/countries_response.dart';
import 'package:ozon/data/response/estimate_shipping_method_response.dart';
import 'package:ozon/data/response/order_response.dart';
import 'package:ozon/data/response/payment_method_response.dart';
import 'package:ozon/data/response/promo_response.dart';
import 'package:ozon/data/response/remove_wish_list_response.dart';
import 'package:ozon/data/response/shipping_information_response.dart';
import 'package:ozon/data/response/splash_response.dart';
import 'package:ozon/data/response/state_response.dart';
import 'package:ozon/data/response/stock_response.dart';
import 'package:ozon/data/response/user_info_response.dart';
import 'package:ozon/data/response/wish_list_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';


import '../../app/constants.dart';
import '../response/add_to_cart_response.dart';
import '../response/add_to_wish_list_response.dart';
import '../response/brands_response.dart';
import '../response/check_stock_response.dart';
import '../response/generate_invoice_response.dart';
import '../response/home_screen_response.dart';
import '../response/location_response.dart';
import '../response/my_orders_response.dart';
import '../response/new_login_response.dart';

import '../response/register_response.dart';
import '../response/sorting_category_response.dart';
import '../response/state_locator_response.dart';
import '../response/version_response.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
  @MultiPart()
  @POST("{storeId}/V1/setting?action=version&type=list")

  Future<HttpResponse<VersionResponse>> version(

  @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId
      );


  @GET("{storeId}/V1/ozoneapp/splashscreen")

  Future<HttpResponse<SplashResponse>> splash(

      @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId

      );
  @GET("{storeId}/V1/inventory/source-items")
  Future<HttpResponse<CheckStockResponse>> checkStockItems(@Queries() Map<String, dynamic> queryParams, @Header( "Authorization") String Authorization,
  @Header( "state-id") String stateId,
  @Header( "store-code") String storeCode,
  @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId,
      );
  @POST("{storeId}/V1/ozone/account/login/")
  Future<HttpResponse<NewLoginResponse>> newLogin(@Body() Map<String, dynamic> body, @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);

  @DELETE("{storeId}/V1/addresses/{id}")
  Future<HttpResponse<bool>> deleteAddress(@Path("id") int id, @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);

  @GET("{storeId}/V1/ozone/filters/{id}")
        Future<HttpResponse<SortingCategoryResponse>> sortingCategory(@Path("id") int id, @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @DELETE("{storeId}/V1/carts/mine/coupons")
  Future<HttpResponse<bool>> deleteCoupoun(
      @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @DELETE("{storeId}/V1/carts/mine/items/{id}")
  Future<HttpResponse<bool>> deleteItemCart(@Path("id") int id, @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @DELETE("{storeId}/V1/customers/{id}")
  Future<HttpResponse<bool>> deleteUserAccount(@Path("id") int id, @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @POST("{storeId}/V1/carts/mine/items")
  Future<HttpResponse<AddToCartResponse>> addToCart(@Body() Map<String, dynamic> body, @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @PUT("{storeId}/V1/carts/mine/items/{id}")
  Future<HttpResponse<AddToCartResponse>> updateCart(@Path("id") int id,@Body() Map<String, dynamic> body, @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @POST("{storeId}/V1/integration/customer/token")
  Future<HttpResponse<String>> login(@Body() Map<String, dynamic> body, @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @POST("{storeId}/V1/customers")
  Future<HttpResponse<RegisterResponse>> register(@Body() Map<String, dynamic> body, @Header( "Authorization") String Authorization, @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @GET("{storeId}/V1/customers/me")
  Future<HttpResponse<UserInfoResponse>> userInfo( @Header( "Authorization") String Authorization, @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
  @Header( "source-code") String   sourceCode,
  @Header( "store") String   store,
  @Path('storeId') String storeId);
  @GET("{storeId}/V1/whatsapp/promo")
  Future<HttpResponse<PromoResponse>> promo( @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType
      , @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);

  @GET("{storeId}/V1/store-locator")
  Future<HttpResponse<StareLocatorResponse>> storeLocator( @Header( "Authorization") String Authorization,@Query("country") String country,@Query("state") String state,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @PUT("{storeId}/V1/customers/password")
  Future<HttpResponse<bool>> forgetPassword(@Body() Map<String, dynamic> body, @Header( "Authorization") String Authorization, @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @GET("{storeId}/V1/categories")
  Future<HttpResponse<CategoryResponse>> categories( @Header( "Authorization") String Authorization, @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @GET("{storeId}/V1/directory/countries")
  Future<HttpResponse<List<CountryResponse>>> countries( @Header( "Authorization") String Authorization, @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @GET("{storeId}/V1/products")
  Future<HttpResponse<ProductsResponse>> getProductsByCategory(
      @Queries() Map<String, dynamic> queryParams,
      @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId
      );

  @GET("{storeId}/V1/ozoneapp-categoryscreen/categoryscreen/search?searchCriteria%5BpageSize%5D=100")
  Future<HttpResponse<CategoryHomeResponse>> getCategoryHome(

      @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId
      );

  @GET("{storeId}/V1/products")
  Future<HttpResponse<ProductsResponse>> getProductDetails(
      @Queries() Map<String, dynamic> queryParams,
      @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId
      );
  @GET("{storeId}/V1/stockItems/{sku}")
  Future<HttpResponse<StockResponse>> getStockInfo(@Path("sku") String sku, @Header( "Authorization") String Authorization, @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @GET("{storeId}/V1/country/{counctyCode}/states")
  Future<HttpResponse<List<StateResponse>>> states(@Path("counctyCode") String counctyCode,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);

  @GET("{storeId}/V1/cityfetch")
  Future<HttpResponse<List<CityResponse>>> cities(@Query("statename") String statename,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @GET("{storeId}/V1/customers/me")
  Future<HttpResponse<AddressesResponse>> getAddresses( @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);

  @PUT("{storeId}/V1/customers/me")
  Future<HttpResponse<AddressesResponse>> addAddress( @Body() Map<String, dynamic> body,@Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @POST("{storeId}/V1/customers/me/changeEmail")
  Future<HttpResponse<bool>> updateProfile(@Body() Map<String, dynamic> body, @Header( "Authorization") String Authorization, @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @POST("{storeId}/V1/customers/me/changePassword")
  Future<HttpResponse<bool>> updatePassword(@Body() Map<String, dynamic> body, @Header( "Authorization") String Authorization, @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);

  @POST("{storeId}/V1/carts/mine/shipping-information")
  Future<HttpResponse<ShippingInformationResponse>> shippingInformation(@Body() Map<String, dynamic> body, @Header( "Authorization") String Authorization, @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @POST("{storeId}/V1/orders/{orderId}/cancel")
  Future<HttpResponse<bool>> cancelOrder(@Path("orderId") String orderId,@Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);

  @GET("{storeId}/V1/carts/mine")
  Future<HttpResponse<OrderResponse>> cart( @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);

  @POST("{storeId}/V1/carts/mine")
  Future<HttpResponse<int>> createCart( @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @POST("{storeId}/V1/carts/mine/estimate-shipping-methods")
  Future<HttpResponse<List<EstimateShippingMethodResponse>>> estimateShippingMethods( @Body() Map<String, dynamic> body,@Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @PUT("{storeId}/V1/carts/mine/coupons/{coupon}")
  Future<HttpResponse<bool>> applyCoupon(@Path("coupon") String coupon, @Header( "Authorization") String Authorization, @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @GET("{storeId}/V1/carts/mine/payment-methods")
  Future<HttpResponse<List<PaymentMethodResponse>>> paymentMethods( @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @GET("{storeId}/V1/me/wishlist")
  Future<HttpResponse<WishListResponse>> wishList( @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @POST("{storeId}/V1/me/wishlist/item/remove/{id}")
  Future<HttpResponse<RemoveWishListResponse>> removeItemWishList( @Header( "Authorization") String Authorization,@Path("id") String id, @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @PUT("{storeId}/V1/me/wishlist/add/{id}")
  Future<HttpResponse<AddToWishListResponse>> AddItemWishList( @Header( "Authorization") String Authorization,@Path("id") String id, @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @POST("{storeId}/V1/contact_us")
  Future<HttpResponse<dynamic>> contactUs( @Body() Map<String, dynamic> body,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @GET("{storeId}/V1/carts/mine/totals")
  Future<HttpResponse<CheckOutResponse>> checkout( @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);

  @GET("{storeId}/V1/ozoneapp-version/version/search?searchCriteria[pageSize]=10")
  Future<HttpResponse<AppVersionResponse>> appVersions( @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @GET("{storeId}/V1/ozoneapp-contact/contact/search?searchCriteria[pageSize]=10")
  Future<HttpResponse<ContactUsResponse>> conactUsDetails( @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @GET("{storeId}/V1/orders")
  Future<HttpResponse<MyOrdersResponse>> orders( @Queries() Map<String, dynamic> queryParams, @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @GET("{storeId}/V1/ozone-screen/screen/1")
  Future<HttpResponse<dynamic>> home( @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @GET("{storeId}/V1/ozone/order-timeline/{orderId}")
  Future<HttpResponse<TimeLineResponse>> timeLine( @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId,
      @Path('orderId') String orderId);
  @GET("{storeId}/V1/brands/collection")
  Future<HttpResponse<List<BrandsDataResponse>>> brands( @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);

  @POST("{storeId}/V1/reviews")
  Future<HttpResponse<RatringResponse>> rating( @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId,
      @Body() Map<String, dynamic> body);

  @POST("{storeId}/V1/myfatoorah/generate")
  Future<HttpResponse<dynamic>> generateInvoice(@Header( "Authorization") String Authorization,@Query("invoiceValue") String invoiceValue,
      @Query("customerName") String customerName,@Query("countryCode") String countryCode,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);
  @PUT("{storeId}/V1/carts/mine/order")
  Future<HttpResponse<int>> order(@Body() Map<String, dynamic> body, @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);


  @POST("{storeId}/V1/ozonemsi-location/location")

  Future<HttpResponse<LocationResponse>> location(
      @Body() Map<String, dynamic> body,
      @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId
      );

  @POST("{storeId}/V1/carts/mine/set-payment-information")
  Future<HttpResponse<bool>> setPaymentInformation(@Body() Map<String, dynamic> body, @Header( "Authorization") String Authorization,
      @Header( "state-id") String stateId,
      @Header( "store-code") String storeCode,
      @Header( "device-type") String deviceType,
      @Header( "source-code") String   sourceCode,
      @Header( "store") String   store,
      @Path('storeId') String storeId);

}