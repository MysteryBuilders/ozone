



import 'package:dartz/dartz.dart';
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

import '../../data/network/failure.dart';
import '../model/brands_model.dart';
import '../model/products_model.dart';
import '../model/version_model.dart';

abstract class Repository {
  Future<Either<Failure, AddToCartModel>> updateCart(int itemId,Map<String,dynamic> map,String authorization);
  Future<Either<Failure, AddToCartModel>> addToCart(Map<String,dynamic> map,String authorization);
  Future<Either<Failure, ProductsModel>> getProductsByCategory(Map<String,dynamic> map,String authorization);
  Future<Either<Failure, NewLoginModel>> newLogin(Map<String,dynamic> map,String authorization);
  Future<Either<Failure, CategoryModel>> category(String authorization);
  Future<Either<Failure, OrderModel>> cart(String authorization);
  Future<Either<Failure, UserInfoModel>> userInfo(String authorization);
  Future<Either<Failure, PromoModel>> promo(String authorization);
  Future<Either<Failure, VersionModel>> versions();
  Future<Either<Failure, SplashModel>> splash();
  Future<Either<Failure, StoreLocatorModel>> storeLocator(String authorization,String country,String state);
  Future<Either<Failure, List<CountryModel>>> countries(String authorization);
  Future<Either<Failure, CustomerDomain>> addresses(String authorization);
  Future<Either<Failure, String>> login(String userName,String password,String authorization);
  Future<Either<Failure, RegisterModel>> register(String email,String firstName,String lastName,String password,String authorization,String phoneNumber,String countryCode,String stateId,String storeCode);
  Future<Either<Failure, bool>> forgetPassword(String email,String authorization);
  Future<Either<Failure, StockModel>> getStockInfo(String sku,String authorization);
  Future<Either<Failure, bool>> updateProfile(String email,String password,String authorization);
  Future<Either<Failure, bool>> updatePassword(String newPassword,String confirmNewPassword,String  currentPassword,String authorization);
  Future<Either<Failure, bool>> deleteItemCart(int itemId,String authorization);
  Future<Either<Failure, bool>> deleteAddress(int itemId,String authorization);
  Future<Either<Failure, bool>> applyCoupon(String coupon,String authorization);
  Future<Either<Failure, List<EstimateShippingMethod>>> estimateShippingMethods(Map<String,dynamic> map,String authorization);
  Future<Either<Failure, CustomerDomain>> addAddress(Map<String,dynamic> map,String authorization);
  Future<Either<Failure, LocationModel>> saveLocation(Map<String,dynamic> map,String authorization);
  Future<Either<Failure, ShippingInformationModel>> shippingInformation(Map<String,dynamic> map,String authorization);
  Future<Either<Failure, List<PaymentMethodModel>>> paymentMethods(String authorization);
  Future<Either<Failure, WishListModel>> wishList(String authorization);
  Future<Either<Failure, RemoveWishListModel>> removeWishItemList(String authorization,String id);
  Future<Either<Failure, AddItemToWishListModel>> addItemToWishItemList(String authorization,String id);
  Future<Either<Failure, String>> contactUs(Map<String,dynamic> map);
  Future<Either<Failure, CheckStockModel>> checkStock(Map<String,dynamic> map,String authorization,);
  Future<Either<Failure, bool>> deleteCouponCode(String authorization);
  Future<Either<Failure, bool>> deleteAccount(int userId,String authorization);
  Future<Either<Failure, List<CityModel>>> cities(String stateName);
  Future<Either<Failure, List<StateModel>>> states(String countryCode);
  Future<Either<Failure, CheckOutModel>> checkout(String authorization);
  Future<Either<Failure, MyOrdersModel>> getMyOrders(Map<String,dynamic> map,String authorization);
  Future<Either<Failure, bool>> cancelOrder(String orderId,String authorization);
  Future<Either<Failure, AppVersionModel>> appVersions(String authorization);
  Future<Either<Failure, ContactUsModel>> contactusDetails(String authorization);
  Future<Either<Failure, ScreenHome>> getHome(String authorization);
  Future<Either<Failure, TimeLine>> timeLine(String authorization,String orderId);
  Future<Either<Failure, List<BrandsDataModel>>> getBrands(String authorization);
  Future<Either<Failure, List<dynamic>>> generateInvoice(String authoriztion, String invoiceValue, String customerName, String countryCode);
  Future<Either<Failure, int>> order(Map<String,dynamic> map,String authorization);
  Future<Either<Failure, int>> createCart(String authorization);
  Future<Either<Failure, CategoryHomeModel>> categoryhome(String authorization);
  Future<Either<Failure, SortingCategoryModel>> sortingCategory(String authorization,int categoryId);

  Future<Either<Failure, bool>> paymentInformation(Map<String,dynamic> map,String authorization);
  Future<Either<Failure, RatingModel>> rating(String authorization,Map<String,dynamic> map);

}