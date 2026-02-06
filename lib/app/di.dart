

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:ozon/app/user_prefrences.dart';
import 'package:ozon/domain/usecases/add_address_use_Case.dart';
import 'package:ozon/domain/usecases/add_item_to_wish_list_usecase.dart';
import 'package:ozon/domain/usecases/add_to_cart_use_case.dart';
import 'package:ozon/domain/usecases/address_use_case.dart';
import 'package:ozon/domain/usecases/app_versions_use_case.dart';
import 'package:ozon/domain/usecases/apply_coupon_usecase.dart';
import 'package:ozon/domain/usecases/cancel_order_use_case.dart';
import 'package:ozon/domain/usecases/cart_use_case.dart';
import 'package:ozon/domain/usecases/categories_usecase.dart';
import 'package:ozon/domain/usecases/check_out_use_case.dart';
import 'package:ozon/domain/usecases/city_use_case.dart';
import 'package:ozon/domain/usecases/contact_us_details_use_case.dart';
import 'package:ozon/domain/usecases/contact_us_use_case.dart';
import 'package:ozon/domain/usecases/countries_use_case.dart';
import 'package:ozon/domain/usecases/create_cart_use_case.dart';
import 'package:ozon/domain/usecases/delete_account_use_case.dart';
import 'package:ozon/domain/usecases/delete_address_use_case.dart';
import 'package:ozon/domain/usecases/delete_coupoun_use_case.dart';
import 'package:ozon/domain/usecases/delete_item_cart_use_case.dart';
import 'package:ozon/domain/usecases/estimate_shipping_method_use_case.dart';
import 'package:ozon/domain/usecases/forget_password_usecase.dart';
import 'package:ozon/domain/usecases/generat_invoice_use_case.dart';
import 'package:ozon/domain/usecases/home_use_case.dart';
import 'package:ozon/domain/usecases/location_use_case.dart';
import 'package:ozon/domain/usecases/login_usecase.dart';
import 'package:ozon/domain/usecases/my_orders_use_case.dart';
import 'package:ozon/domain/usecases/order_use_case.dart';
import 'package:ozon/domain/usecases/payment_methods_usecase.dart';
import 'package:ozon/domain/usecases/product_use_case.dart';
import 'package:ozon/domain/usecases/promo_use_case.dart';
import 'package:ozon/domain/usecases/rating_usecase.dart';
import 'package:ozon/domain/usecases/register_usecase.dart';
import 'package:ozon/domain/usecases/remove_wish_list_use_case.dart';
import 'package:ozon/domain/usecases/set_payment_information_use_case.dart';
import 'package:ozon/domain/usecases/shipping_information_use_case.dart';
import 'package:ozon/domain/usecases/sort_category_use_case.dart';
import 'package:ozon/domain/usecases/splash_use_case.dart';
import 'package:ozon/domain/usecases/states_use_case.dart';
import 'package:ozon/domain/usecases/stock_info_usecase.dart';
import 'package:ozon/domain/usecases/store_locator_use_case.dart';
import 'package:ozon/domain/usecases/time_line_use_case.dart';
import 'package:ozon/domain/usecases/update_cart_use_case.dart';
import 'package:ozon/domain/usecases/update_password_use_case.dart';
import 'package:ozon/domain/usecases/update_profile_use_case.dart';
import 'package:ozon/domain/usecases/user_info_use_case.dart';
import 'package:ozon/domain/usecases/wishlist_use_case.dart';
import 'package:ozon/presentation/add_address/bloc/add_address_bloc/add_address_bloc.dart';
import 'package:ozon/presentation/add_address/bloc/checkbox_bloc.dart';
import 'package:ozon/presentation/add_address/bloc/default_city_bloc/default_city_bloc.dart';
import 'package:ozon/presentation/addresses/bloc/addresses_bloc.dart';
import 'package:ozon/presentation/addresses/bloc/delete_address_bloc/delete_address_bloc.dart';
import 'package:ozon/presentation/brands/bloc/brand_select_bloc/brand_select_bloc.dart';
import 'package:ozon/presentation/check_out/check_out_bloc/check_out_bloc.dart';
import 'package:ozon/presentation/check_out/delete_coupoun_bloc/delete_coupoun_bloc.dart';
import 'package:ozon/presentation/check_out/generate_invoice_bloc/generate_invoice_bloc.dart';
import 'package:ozon/presentation/cities/bloc/cities_bloc.dart';
import 'package:ozon/presentation/contact_us/bloc/contact_us_bloc.dart';
import 'package:ozon/presentation/contact_us/contact_us_details_bloc/contact_us_details_bloc.dart';
import 'package:ozon/presentation/country/bloc/country_result_bloc/country_result_bloc.dart';
import 'package:ozon/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:ozon/presentation/edit_profile/bloc/select_image/select_image_bloc.dart';
import 'package:ozon/presentation/leave_review/bloc/rating_bloc/rating_bloc.dart';
import 'package:ozon/presentation/location/bloc/location_bloc/current_location_bloc.dart';
import 'package:ozon/presentation/location/bloc/save_location_bloc/save_location_bloc.dart';
import 'package:ozon/presentation/login/bloc/login_bloc.dart';
import 'package:ozon/presentation/main/bloc/add_to_cart/add_to_cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/apply_coupon_bloc/apply_coupon_bloc.dart';
import 'package:ozon/presentation/main/bloc/back_button_bloc/back_button_bloc.dart';
import 'package:ozon/presentation/main/bloc/before_after_bloc/before_after_bloc.dart';
import 'package:ozon/presentation/main/bloc/carousel_slider_bloc/carousel_slider_bloc.dart';
import 'package:ozon/presentation/main/bloc/cart_bloc/cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/cart_local/cart_local_bloc.dart';
import 'package:ozon/presentation/main/bloc/categories_bloc/categories_bloc.dart';
import 'package:ozon/presentation/main/bloc/category_bloc/category_bloc.dart';
import 'package:ozon/presentation/main/bloc/check_cart/check_cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/create_cart_bloc/create_cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/delete_account_bloc/delete_account_bloc.dart';
import 'package:ozon/presentation/main/bloc/delete_item_cart/delete_item_cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/estimate_method_bloc/estimate_method_bloc.dart';
import 'package:ozon/presentation/main/bloc/home_bloc/home_bloc.dart';
import 'package:ozon/presentation/main/bloc/main_bloc/main_bloc.dart';
import 'package:ozon/presentation/main/bloc/offers_bloc/load_more_bloc.dart';
import 'package:ozon/presentation/main/bloc/payment_methods_bloc/payment_methods_bloc.dart';
import 'package:ozon/presentation/main/bloc/promo_bloc/promo_bloc.dart';
import 'package:ozon/presentation/main/bloc/shipping_information/shipping_information_bloc.dart';
import 'package:ozon/presentation/main/bloc/slider_view_bloc/slider_view_bloc.dart';
import 'package:ozon/presentation/main/bloc/store_locator_bloc/store_locator_bloc.dart';
import 'package:ozon/presentation/main/bloc/update_cart/update_cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/user_bloc/user_bloc.dart';
import 'package:ozon/presentation/my_orders/bloc/cancel_order_bloc/cancel_order_bloc.dart';
import 'package:ozon/presentation/my_orders/bloc/my_orders_bloc.dart';
import 'package:ozon/presentation/my_orders/bloc/status_bloc/status_bloc.dart';
import 'package:ozon/presentation/order_details/bloc/check_status_bloc.dart';
import 'package:ozon/presentation/order_details/bloc/time_line_order_bloc/time_line_bloc.dart';
import 'package:ozon/presentation/payment/order_bloc/order_bloc.dart';
import 'package:ozon/presentation/payment/payment_bloc/payment_bloc.dart';
import 'package:ozon/presentation/payment_method_view/bloc/set_payment_information_bloc.dart';
import 'package:ozon/presentation/privacy/bloc/web_view_bloc.dart';
import 'package:ozon/presentation/product_details/bloc/counter_bloc.dart';
import 'package:ozon/presentation/product_details/bloc/stock_info_bloc.dart';
import 'package:ozon/presentation/products/bloc/add_item_to_wish_list/add_item_to_wish_list_bloc.dart';
import 'package:ozon/presentation/products/bloc/products_bloc.dart';
import 'package:ozon/presentation/products/bloc/sort_category_bloc/sort_category_bloc.dart';
import 'package:ozon/presentation/register/bloc/register_bloc.dart';
import 'package:ozon/presentation/set_new_password/bloc/set_new_password_bloc.dart';
import 'package:ozon/presentation/splash/bloc/app_Versions_bloc/app_versions_bloc.dart';
import 'package:ozon/presentation/splash/bloc/gif_bloc/gif_bloc.dart';
import 'package:ozon/presentation/splash/bloc/new_splash_bloc/new_splash_bloc.dart';

import 'package:ozon/presentation/splash/bloc/notification_bloc/notification_bloc.dart';

import 'package:ozon/presentation/splash/bloc/splash_bloc/splash_bloc.dart';
import 'package:ozon/presentation/states/bloc/states_bloc.dart';
import 'package:ozon/presentation/wishlist/bloc/remove_wish_list_bloc/remove_wish_list_bloc.dart';
import 'package:ozon/presentation/wishlist/bloc/wish_list_bloc.dart';


import 'package:shared_preferences/shared_preferences.dart';


import '../data/data_source/local_data_source.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/network/dio_map_factory.dart';
import '../data/network/network_info.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/usecases/brands_use_case.dart';
import '../domain/usecases/categories_home_usecase.dart';
import '../presentation/brands/bloc/brands_bloc.dart';
import '../presentation/country/bloc/country_bloc.dart';
import '../presentation/forget_password/bloc/forget_password_bloc.dart';
import '../presentation/language/bloc/language_bloc.dart';
import '../presentation/leave_review/bloc/leave_review_bloc/leave_review_bloc.dart';
import '../presentation/main/bloc/categories_home_bloc/categories_home_bloc.dart';
import '../presentation/main/bloc/count_down_bloc/counter_bloc.dart';
import '../presentation/product_details/bloc/caursel_bloc.dart';
import '../presentation/product_details/bloc/product_option_bloc/product_option_bloc.dart';
import '../presentation/product_details/bloc/range_bloc/price_range_bloc.dart';
import '../presentation/states/bloc/states_result_bloc/states_reult_bloc.dart';
import 'app_prefrences.dart';
import 'constants.dart';


final instance = GetIt.instance;
Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();
  final firebaseMessaging = FirebaseMessaging.instance;
  instance.registerLazySingleton<FirebaseMessaging>(() => firebaseMessaging);

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  instance.registerSingleton<UserPreferences>(UserPreferences());
  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(InternetConnection()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  instance.registerLazySingleton<DioMapFactory>(() => DioMapFactory(instance()));
  Dio dio = await instance<DioFactory>().getDio();
  Dio dioMap = await instance<DioMapFactory>().getDio();
  AppPreferences _appPrefrencesce = instance<AppPreferences>();
   String storeCode = await _appPrefrencesce.getStoreCode();
  final String dynamicBaseUrl = "${Constants.baseUrl}/$storeCode/V1/";

  //app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSourceImpl(instance<AppServiceClient>(),instance()));

  // local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
  instance.registerLazySingleton<Repository>(
          () => RepositoryImpl(instance(), instance(), instance(),instance()));
  instance.registerFactory<SliderViewBloc>(() => SliderViewBloc());
  instance.registerFactory<ImagePickerBloc>(() => ImagePickerBloc());
  instance.registerFactory<CurrentLocationBloc>(() => CurrentLocationBloc());
  instance.registerFactory<PriceRangeBloc>(() => PriceRangeBloc());
  instance.registerFactory<CarouselBloc>(() => CarouselBloc());
  instance.registerFactory<StatusBloc>(() => StatusBloc());
  instance.registerFactory<RatingBloc>(() => RatingBloc());
  instance.registerFactory<CheckStatusBloc>(() => CheckStatusBloc());
  instance.registerFactory<ProductOptionBloc>(() => ProductOptionBloc());
  // repository
  instance.registerFactory<PaymentBloc>(() => PaymentBloc(instance()));
  instance.registerFactory<BeforeAfterBloc>(() => BeforeAfterBloc());
  instance.registerFactory<CountdownBloc>(() => CountdownBloc());
  instance.registerFactory<CarouselSLiderBloc>(() => CarouselSLiderBloc());
  instance.registerFactory<AddressUseCase>(() => AddressUseCase(instance()));
  instance.registerSingleton(AddressesBloc(instance()));
  instance.registerFactory<CheckboxBloc>(() => CheckboxBloc());
  instance.registerFactory<AddAddressUseCase>(() => AddAddressUseCase(instance()));
  instance.registerFactory<AddAddressBloc>(() => AddAddressBloc(instance()));

  instance.registerFactory<SortCategoryUseCase>(() => SortCategoryUseCase(instance()));
  instance.registerFactory<SortCategoryBloc>(() => SortCategoryBloc(instance()));

  instance.registerFactory<DefaultCityBloc>(() => DefaultCityBloc(instance()));
  instance.registerFactory<GenerateInvoiceUseCase>(() => GenerateInvoiceUseCase(instance()));
  instance.registerFactory<GenerateInvoiceBloc>(() => GenerateInvoiceBloc(instance()));

  instance.registerFactory<StoreLocatorUseCase>(() => StoreLocatorUseCase(instance()));
  instance.registerFactory<StoreLocatorBloc>(() => StoreLocatorBloc(instance()));


  instance.registerFactory<PromoUseCase>(() => PromoUseCase(instance()));

  instance.registerFactory<PromoBloc>(() => PromoBloc(instance()));
  instance.registerFactory<CategoriesHomeUsecase>(() => CategoriesHomeUsecase(instance()));
  instance.registerSingleton(CategoriesHomeBloc(instance()));

  instance.registerFactory<CheckOutUseCase>(() => CheckOutUseCase(instance()));
  instance.registerFactory<CheckOutBloc>(() => CheckOutBloc(instance()));
  instance.registerFactory<AppVersionsUseCase>(() => AppVersionsUseCase(instance()));
  instance.registerFactory<AppVersionsBloc>(() => AppVersionsBloc(instance()));

  instance.registerFactory<ContactUsDetailsUseCase>(() => ContactUsDetailsUseCase(instance()));
  instance.registerFactory<ContactUsDetailsBloc>(() => ContactUsDetailsBloc(instance()));

  instance.registerFactory<CategoryBloc>(() => CategoryBloc());
  instance.registerFactory<DeleteCoupounUseCase>(() => DeleteCoupounUseCase(instance()));
  instance.registerFactory<DeleteCoupounBloc>(() => DeleteCoupounBloc(instance()));

  instance.registerFactory<CountriesUseCase>(() => CountriesUseCase(instance()));
  instance.registerFactory<ApplyCouponUsecase>(() => ApplyCouponUsecase(instance()));
  instance.registerFactory<ApplyCouponBloc>(() => ApplyCouponBloc(instance()));
  instance.registerFactory<MyOrdersUseCase>(() => MyOrdersUseCase(instance()));
  instance.registerFactory<MyOrdersBloc>(() => MyOrdersBloc(instance()));
  instance.registerFactory<RatingUsecase>(() => RatingUsecase(instance()));
  instance.registerFactory<LeaveReviewBloc>(() => LeaveReviewBloc(instance()));
  instance.registerFactory<WishlistUseCase>(() => WishlistUseCase(instance()));
  // instance.registerFactory<WishListBloc>(() => WishListBloc(instance()));
  instance.registerSingleton(WishListBloc(instance()));
  instance.registerFactory<RemoveWishListUseCase>(() => RemoveWishListUseCase(instance()));
  instance.registerFactory<RemoveWishListBloc>(() => RemoveWishListBloc(instance()));
  instance.registerFactory<ShippingInformationUseCase>(() => ShippingInformationUseCase(instance()));
  instance.registerFactory<ShippingInformationBloc>(() => ShippingInformationBloc(instance()));
  instance.registerFactory<EstimateShippingMethodUseCase>(() => EstimateShippingMethodUseCase(instance()));
  instance.registerFactory<EstimateMethodBloc>(() => EstimateMethodBloc(instance()));
  instance.registerFactory<PaymentMethodsUsecase>(() => PaymentMethodsUsecase(instance()));
  instance.registerFactory<PaymentMethodsBloc>(() => PaymentMethodsBloc(instance()));
  instance.registerFactory<TimeLineUseCase>(() => TimeLineUseCase(instance()));
  instance.registerFactory<TimeLineBloc>(() => TimeLineBloc(instance()));
  instance.registerFactory<AddItemToWishListUsecase>(() => AddItemToWishListUsecase(instance()));
  instance.registerFactory<AddItemToWishListBloc>(() => AddItemToWishListBloc(instance()));
  instance.registerFactory<DeleteAccountUseCase>(() => DeleteAccountUseCase(instance()));
  instance.registerFactory<DeleteAccountBloc>(() => DeleteAccountBloc(instance()));
  instance.registerFactory<ContactUsUseCase>(() => ContactUsUseCase(instance()));
  instance.registerFactory<ContactUsBloc>(() => ContactUsBloc(instance()));
  instance.registerFactory<CancelOrderUseCase>(() => CancelOrderUseCase(instance()));
  instance.registerFactory<CancelOrderBloc>(() => CancelOrderBloc(instance()));
  instance.registerFactory<CountryResultBloc>(() => CountryResultBloc());
  instance.registerFactory<StatesReultBloc>(() => StatesReultBloc());

  instance.registerFactory<CountryBloc>(() => CountryBloc(instance()));
  instance.registerFactory<StatesUseCase>(() => StatesUseCase(instance()));
  instance.registerFactory<StatesBloc>(() => StatesBloc(instance()));
  instance.registerFactory<CityUseCase>(() => CityUseCase(instance()));
  instance.registerSingleton(CitiesBloc(instance()));
  instance.registerSingleton<CartLocalBloc>( CartLocalBloc());
  instance.registerFactory<LoadMoreBloc>(() => LoadMoreBloc(instance()));
  instance.registerFactory<CounterBloc>(() => CounterBloc());
  instance.registerSingleton(LocalizationBloc());
  instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
  instance.registerFactory<LoginBloc>(() => LoginBloc(instance()));
  instance.registerFactory<StockInfoUseCase>(() => StockInfoUseCase(instance(),instance()));
  instance.registerFactory<StockInfoBloc>(() => StockInfoBloc(instance()));
  instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
  instance.registerFactory<HomeBloc>(() => HomeBloc(instance()));
  instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
  instance.registerFactory<ProductUseCase>(() => ProductUseCase(instance()));
  instance.registerFactory<ProductsBloc>(() => ProductsBloc(instance()));
  instance.registerFactory<RegisterBloc>(() => RegisterBloc(instance()));
  instance.registerFactory<ForgetPasswordUseCase>(() => ForgetPasswordUseCase(instance()));
  instance.registerFactory<ForgetPasswordBloc>(() => ForgetPasswordBloc(instance()));
  instance.registerFactory<MainBloc>(() => MainBloc());
  instance.registerFactory<SplashBloc>(() => SplashBloc());
  instance.registerFactory<WebViewBloc>(() => WebViewBloc());
  instance.registerFactory<FlutterLocalNotificationsPlugin>(() => FlutterLocalNotificationsPlugin());
  instance.registerLazySingleton<NotificationBloc>(() => NotificationBloc(instance()));
  instance.registerFactory<CheckCartBloc>(() => CheckCartBloc(instance()));

  instance.registerFactory<CategoriesUseCase>(() => CategoriesUseCase(instance()));
  instance.registerFactory<CategoriesBloc>(() => CategoriesBloc(instance()));
  instance.registerFactory<CartUseCase>(() => CartUseCase(instance()));
  instance.registerLazySingleton<CartBloc>(() => CartBloc(instance()));
  instance.registerFactory<AddToCartUseCase>(() => AddToCartUseCase(instance()));
  instance.registerFactory<AddToCartBloc>(() => AddToCartBloc(instance()));
  instance.registerFactory<DeleteItemCartUseCase>(() => DeleteItemCartUseCase(instance()));
  instance.registerFactory<DeleteItemCartBloc>(() => DeleteItemCartBloc(instance()));
  instance.registerFactory<UpdateCartUseCase>(() => UpdateCartUseCase(instance()));
  instance.registerFactory<UpdateCartBloc>(() => UpdateCartBloc(instance()));

  instance.registerFactory<UserInfoUseCase>(() => UserInfoUseCase(instance()));
  instance.registerFactory<DeleteAddressUseCase>(() => DeleteAddressUseCase(instance()));
  instance.registerFactory<DeleteAddressBloc>(() => DeleteAddressBloc(instance()));
  instance.registerFactory<UpdateProfileUseCase>(() => UpdateProfileUseCase(instance()));
  instance.registerFactory<EditProfileBloc>(() => EditProfileBloc(instance()));
  instance.registerFactory<UpdatePasswordUseCase>(() => UpdatePasswordUseCase(instance()));
  instance.registerFactory<SetNewPasswordBloc>(() => SetNewPasswordBloc(instance()));
  instance.registerFactory<UserBloc>(() => UserBloc(instance()));
  instance.registerFactory<BrandsUseCase>(() => BrandsUseCase(instance()));
  instance.registerFactory<BrandsBloc>(() => BrandsBloc(instance()));
  instance.registerFactory<BrandSelectBloc>(() => BrandSelectBloc());
  instance.registerFactory<OrderUseCase>(() => OrderUseCase(instance()));
  instance.registerFactory<OrderBloc>(() => OrderBloc(instance()));
  instance.registerFactory<CreateCartUseCase>(() => CreateCartUseCase(instance()));
  instance.registerFactory<CreateCartBloc>(() => CreateCartBloc(instance()));
  instance.registerSingleton(BackButtonBloc());
  instance.registerFactory<SplashUseCase>(() => SplashUseCase(instance()));
  instance.registerFactory<NewSplashBloc>(() => NewSplashBloc(instance()));
  instance.registerFactory<GifBloc>(() => GifBloc());
  instance.registerFactory<LocationUseCase>(() => LocationUseCase(instance()));
  instance.registerFactory<SaveLocationBloc>(() => SaveLocationBloc(instance()));
  instance.registerFactory<SetPaymentInformationUseCase>(() => SetPaymentInformationUseCase(instance()));
  instance.registerFactory<SetPaymentInformationBloc>(() => SetPaymentInformationBloc(instance()));
}

// initForgetPasswordModule() {
//   if (!GetIt.I.isRegistered<ForgetPasswordUseCase>()) {
//     instance.registerFactory<ForgetPasswordUseCase>(() => ForgetPasswordUseCase(instance()));
//     instance.registerFactory<ForgetPasswordViewModel>(() => ForgetPasswordViewModel(instance()));
//   }
// }