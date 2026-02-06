



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ozon/domain/model/adresses_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/home_screen_model.dart';
import 'package:ozon/domain/model/my_orders_model.dart';
import 'package:ozon/domain/model/products_model.dart';

import 'package:ozon/domain/model/user_info_model.dart';
import 'package:ozon/presentation/add_address/view/add_address_view.dart';
import 'package:ozon/presentation/address_details/view/address_details_view.dart';
import 'package:ozon/presentation/addresses/view/addresses_view.dart';
import 'package:ozon/presentation/brands_products/view/brands_products_view.dart';
import 'package:ozon/presentation/categories/view/categories_view.dart';
import 'package:ozon/presentation/check_out/view/check_out_view.dart';
import 'package:ozon/presentation/cities/view/cities_view.dart';
import 'package:ozon/presentation/contact_us/view/contact_us_view.dart';
import 'package:ozon/presentation/country/view/country_view.dart';
import 'package:ozon/presentation/edit_profile/view/edit_profile_view.dart';
import 'package:ozon/presentation/leave_review/view/leave_review_view.dart';
import 'package:ozon/presentation/location/view/location_view.dart';
import 'package:ozon/presentation/login/view/login_view.dart';
import 'package:ozon/presentation/main/bloc/back_button_bloc/back_button_bloc.dart';
import 'package:ozon/presentation/main/bloc/cart_bloc/cart_bloc.dart';
import 'package:ozon/presentation/main/view/cart_view.dart';
import 'package:ozon/presentation/main/view/home_widget/home_category_widget.dart';
import 'package:ozon/presentation/main/view/main_view.dart';
import 'package:ozon/presentation/my_orders/view/my_orders_view.dart';
import 'package:ozon/presentation/order_details/order_details_view/order_details_view.dart';
import 'package:ozon/presentation/payment/view/payment_view.dart';
import 'package:ozon/presentation/payment_method_view/view/payment_method_view.dart';
import 'package:ozon/presentation/privacy/view/privacy_view.dart';
import 'package:ozon/presentation/product_details/view/product_details_view.dart';
import 'package:ozon/presentation/product_details_home_view/view/product_details_home_view.dart';
import 'package:ozon/presentation/products/view/view/products_view.dart';
import 'package:ozon/presentation/register/view/register_view.dart';

import 'package:ozon/presentation/resources/strings_manager.dart';
import 'package:ozon/presentation/search/view/search_view.dart';
import 'package:ozon/presentation/set_new_password/view/set_new_password_view.dart';
import 'package:ozon/presentation/states/view/states_view.dart';
import 'package:ozon/presentation/subcategories/sub_categories_view.dart';
import 'package:ozon/presentation/subcategories_home/sub_categories_home_view.dart';
import 'package:ozon/presentation/success_payment/view/success_payment.dart';
import 'package:ozon/presentation/widgets/loading_view.dart';
import 'package:ozon/presentation/wishlist/view/wishlist_view.dart';
import 'package:ozon/presentation/zoom_view/zoom_view.dart';

import '../../app/di.dart';
import '../../domain/model/estimate_shipping_method.dart';
import '../../domain/model/shipping_information_model.dart';
import '../forget_password/view/reset_password_view.dart';
import '../select_payment_address/view/selecet_payment_view.dart';
import '../splash/view/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String successRoute = "/success";
  static const String contactUsRoute = "/contactUs";
  static const String searchRoute = "/search";
  static const String cartRoute = "/cart";
  static const String loginRoute = "/login";
  static const String loadingRoute = "/loading";
  static const String registerRoute = "/register";
  static const String productsRoute = "/products";
  static const String categoriesRoute = "/categories";
  static const String productDetailsRoute = "/productDetails";
  static const String productDetailsHomeRoute = "/productDetailsHome";
  static const String orderDetailsRoute = "/orderDetailsRoute";
  static const String mainRoute = "/main";
  static const String resetPasswordRoute = "/resetPassword";
  static const String subCategoriesRoute = "/subCategoriesRoute";
  static const String userProfileRoute = "/userProfileRoute";
  static const String setNewPasswordRoute = "/setNewPasswordRoute";
  static const String privacyRoute = "/privacyRoute";
  static const String selectAddressRoute = "/selectAddressRoute";
  static const String addressRoute = "/addressRoute";
  static const String addAddressRoute = "/addAddressRoute";
  static const String countryRoute = "/countryRoute";
  static const String checkOutRoute = "/checkOutRoute";
  static const String wishListRoute = "/wishListRoute";
  static const String statesRoute = "/statesRoute";
  static const String citiesRoute = "/citiesRoute";
  static const String paymentRoute = "/paymentRoute";
  static const String locationRoute = "/locationRoute";
  static const String paymentMyFatorahRoute = "/paymentMyfatorahRoute";
  static const String zoomRoute = "/zoomRoute";
  static const String brandsProductsRoute = "/brandsProductRoute";
  static const String myOrdersRoute = "/myOrdersRoute";
  static const String addressDetailsRoute = "/addressDetailsRoute";
  static const String myHomeOffersRoute = "/homeOffers";
  static const String paymentMethodRoute = "/paymentMethodRoute";
  static const String subCategoriesHomeRoute = "/subCategoriesHomeRoute";
  static const String leaveReviewRoute = "/leaveReviewRoute";
// Global Navigator Key (fallback)

  static final List<Map<String, dynamic>> navigationStack = [];

  // Navigator keys for individual tabs
  static  List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(), // Tab 0 (e.g., Home)
    GlobalKey<NavigatorState>(), // Tab 1 (e.g., Categories)
    GlobalKey<NavigatorState>(), // Tab 2 (e.g., Brands)
    GlobalKey<NavigatorState>(), // Tab 2 (e.g., MyAccount)
  ];

  static resetNavigatorKeys() {
 navigatorKeys = List.generate(4, (_) => GlobalKey<NavigatorState>());
  }
  // Current active tab index
  static int currentTabIndex = 0;

  /// Navigate to a route within the current tab
  static Future<T?> navigateTo<T>(String routeName, {Object? arguments}) async {
    final navigatorState = getCurrentNavigatorState();
    if (navigatorState != null) {
      try {
        // Push a new route and wait for the result
        final result = await navigatorState.push(
            _createRoute(routeName, arguments));

        // Show the bottom bar after navigation completes


        return result; // Return the result to the caller
      } catch (e) {
        // Handle navigation errors
        print("Error during navigation: $e");
        rethrow;
      }
    } else {
      throw Exception("Navigator for the current tab not found!");
    }
  }


  /// Push a replacement route within the current tab
  static Future<void> pushReplacement(String routeName,
      {Object? arguments}) async {
    final navigatorState = getCurrentNavigatorState();
    if (navigatorState != null) {
      await navigatorState.pushReplacement(_createRoute(routeName, arguments));
    }
    throw Exception("Navigator for the current tab not found!");
  }

  /// Push and clear stack within the current tab
  static Future<void> pushAndRemoveUntilKeepingFirst(String routeName,
      {Object? arguments}) async {
    final navigatorState = getCurrentNavigatorState();

    if (navigatorState != null) {
      await navigatorState.pushAndRemoveUntil(
        _createRoute(routeName, arguments),
            (route) => route.isFirst, // Keep only the first screen
      );

      // Clear stack but keep first route
      if (navigationStack.isNotEmpty) {
        navigationStack.removeRange(1, navigationStack.length);
      }

      // Ensure BackButtonBloc updates properly
      if (GetIt.I.isRegistered<BackButtonBloc>()) {
        GetIt.I<BackButtonBloc>().add(
            UpdateBackButtonEvent(false, navigationStack.first["title"]));
      }
    } else {
      throw Exception("Navigator for the current tab not found!");
    }
  }

  /// Go back within the current tab's navigator
  static void goBack<T>({T? result}) {
    final navigatorState = getCurrentNavigatorState();

    if (navigatorState?.canPop() ?? false) {
      navigatorState?.pop(result);

      // Remove the last route from the stack
      if (navigationStack.isNotEmpty) {
        navigationStack.removeLast();
      }

      // Emit event to update BackButtonBloc based on previous route
      if (navigationStack.isNotEmpty) {
        bool previousShowBackButton = navigationStack.last["showBackButton"];
        String title = navigationStack.last['title'];
        GetIt.I<BackButtonBloc>().add(
            UpdateBackButtonEvent(previousShowBackButton, title));
      } else {
        GetIt.I<BackButtonBloc>().add(UpdateBackButtonEvent(false, ""));
      }
    } else {
      throw Exception(
          "Cannot go back - no navigator available or stack is empty.");
    }
  }

  static bool shouldShowBackButton(String routeName) {
    // Define which routes should show/hide the back button
    List<String> noBackButtonRoutes = [
      Routes.mainRoute,
      Routes.splashRoute,
      Routes.loginRoute,
      Routes.registerRoute
    ];

    return !noBackButtonRoutes.contains(routeName);
  }

  /// Create a MaterialPageRoute based on the route name and arguments
  static Route<dynamic> _createRoute(String routeName, Object? args) {
    bool showBackButton = shouldShowBackButton(routeName);
    // Push the new route onto the stack
    final arguments = (args as Map?) ?? {"title": ""};
    String title = arguments['title'] ?? "";
    navigationStack.add({
      "route": routeName,
      "showBackButton": showBackButton,
      "title": showBackButton ? title : ""
    });

    // Emit event to update back button visibility
    GetIt.I<BackButtonBloc>().add(UpdateBackButtonEvent(showBackButton, title));

    switch (routeName) {
      case Routes.zoomRoute:
        String url = arguments['url'];
        return MaterialPageRoute(builder: (_) => ZoomView(url: url,));
      case Routes.cartRoute:
        return MaterialPageRoute(builder: (_) => CartView());
      case Routes.categoriesRoute:
        return MaterialPageRoute(builder: (_) => CategoriesView());

      case Routes.selectAddressRoute:
        return MaterialPageRoute(builder: (_) => SelecetPaymentView());
      case Routes.checkOutRoute:
        final arguments = args as Map;
        EstimateShippingMethod estimatedShippingMethod = arguments['estimatedShippingMethod'];
        ShippingInformationModel shippingInformationMethod = arguments['shippingInformationMethod'];
        AddressDomain addressDomain = arguments['addressDomain'];
        return MaterialPageRoute(builder: (_) =>
            CheckOutView(estimatedShippingMethod: estimatedShippingMethod,
              shippingInformationMethod: shippingInformationMethod,addressDomain: addressDomain,));
      case Routes.paymentMethodRoute:
        final arguments = args as Map;
        List<
            PaymentMethodInformationModel> paymentMethods = arguments['paymentMethods'];
        AddressDomain addressDomain = arguments['addressDomain'];


        return MaterialPageRoute(
            builder: (_) => PaymentMethodView(paymentMethods: paymentMethods,addressDomain: addressDomain,));

      case Routes.wishListRoute:
        return MaterialPageRoute(builder: (_) => WishlistView());
      case Routes.myHomeOffersRoute:
        final arguments = args as Map;
        String categoryId = arguments['categoryId'];
        return MaterialPageRoute(
            builder: (_) => HomeCategoryWidget(categoryId: categoryId));
      case Routes.brandsProductsRoute:
        final arguments = args as Map;
        String brandName = arguments['brandName'];
        String brandId = arguments['brandId'];
        return MaterialPageRoute(builder: (_) =>
            BrandsProductsView(brandId: brandId, brandName: brandName,));

      case Routes.myOrdersRoute:
        return MaterialPageRoute(builder: (_) => MyOrdersView());
      case Routes.leaveReviewRoute:
        final arguments = args as Map;
        ProductMyItemModel myItemModel = arguments['myItemModel'];
        return MaterialPageRoute(builder: (_) => LeaveReviewView(myItemModel: myItemModel,));
      case Routes.successRoute:
        final arguments = args as Map;
        int orderId = arguments['orderId'];
        return MaterialPageRoute(
            builder: (_) => SuccessPayment(OrderId: orderId,));
      case Routes.privacyRoute:
        return MaterialPageRoute(builder: (_) => PrivacyView());
      case Routes.contactUsRoute:
        return MaterialPageRoute(builder: (_) => const ContactUsView());
      case Routes.countryRoute:
        return MaterialPageRoute(builder: (_) => const CountryView());

      case Routes.addressRoute:
        final arguments = args as Map;
        bool fromCart = arguments['fromCart'];
        return MaterialPageRoute(
            builder: (_) => AddressesView(fromCart: fromCart,));
      case Routes.orderDetailsRoute:
        final arguments = args as Map;
        MyItemModel myItemModel = arguments['myItemModel'];
        return MaterialPageRoute(
            builder: (_) => OrderDetailsView(myItemModel: myItemModel,));


      case Routes.addAddressRoute:
        return MaterialPageRoute(builder: (_) => const AddAddressView());

      case Routes.searchRoute:
        final arguments = args as Map;
        String mSearchText = arguments['searchText'];
        return MaterialPageRoute(builder: (_) =>  SearchView(searchText: mSearchText,));
      case Routes.loadingRoute:
        return MaterialPageRoute(builder: (_) => const LoadingStates());
      case Routes.productsRoute:
        final arguments = args as Map;
        String categoryName = arguments['categoryName'];
        String categoryId = arguments['categoryId'];

        return MaterialPageRoute(builder: (_) =>
            ProductsView(categoryName: categoryName, categoryId: categoryId,));
      case Routes.productDetailsRoute:
        final arguments = args as Map;
        ProductItemModel productModel = arguments['productDetails'];

        return MaterialPageRoute(
            builder: (_) => ProductDetailsView(productModel: productModel));
      case Routes.productDetailsHomeRoute:
        final arguments = args as Map;
        String productId = arguments['productId'];

        return MaterialPageRoute(
            builder: (_) => ProductDetailsHomeView(productId: productId,));

      case Routes.statesRoute:
        final arguments = args as Map;
        String countryCode = arguments['countryCode'];

        return MaterialPageRoute(
            builder: (_) => StatesView(countryCode: countryCode));
      case Routes.citiesRoute:
        final arguments = args as Map;
        String stateName = arguments['stateName'];

        return MaterialPageRoute(
            builder: (_) => CitiesView(stateName: stateName));
      case Routes.addressDetailsRoute:
        final arguments = args as Map;
        AddressDomain addressDomain = arguments['addressDomain'];

        return MaterialPageRoute(
            builder: (_) => AddressDetailsView(addressDomain: addressDomain));

      case Routes.subCategoriesHomeRoute:
        final arguments = args as Map;
        CategoryComponentHome categoryModel = arguments['categoryModel'];
        return MaterialPageRoute(builder: (_) =>
            SubCategoriesHomeView(categoryModel: categoryModel));


      case Routes.subCategoriesRoute:
        final arguments = args as Map;
        CategoryModel categoryModel = arguments['categoryModel'];
        return MaterialPageRoute(
            builder: (_) => SubCategoriesView(categoryModel: categoryModel));
      case Routes.userProfileRoute:
        final arguments = args as Map;
        UserInfoModel userInfoModel = arguments['userInfoModel'];
        return MaterialPageRoute(
            builder: (_) => EditProfileView(userInfoModel: userInfoModel));
      case Routes.setNewPasswordRoute:
        final arguments = args as Map;
        UserInfoModel userInfoModel = arguments['userInfoModel'];
        return MaterialPageRoute(
            builder: (_) => SetNewPasswordView(userInfoModel: userInfoModel));

      case Routes.resetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ResetPasswordView());
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.mainRoute:
        String id = "";
        String type = "";
        Map? arguments;
        if (args != null) {
          arguments = args;
          id = arguments["id"] ?? "";
          type = arguments["type"] ?? "";
        }
        return MaterialPageRoute(builder: (_) => MainView(type: type, id: id,));
      case Routes.paymentRoute:
        final arguments = args as Map;
        String url = arguments['url'];
        String invoiceId = arguments['invoiceId'];
        String paymentMethod = arguments['paymentMethod'];
        double amount = arguments['amount'];
        return MaterialPageRoute(builder: (_) =>
            PaymentView(url: url,
              invoiceId: invoiceId,
              paymentMethod: paymentMethod,
              amount: amount,));

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) =>
            Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }

  /// Get the NavigatorState for the current tab
  static NavigatorState? getCurrentNavigatorState() {
    if (currentTabIndex >= 0 && currentTabIndex < navigatorKeys.length) {
      return navigatorKeys[currentTabIndex].currentState;
    }
    return null;
  }

/// Navigate globally using the global navigator key
//   static Future<void> navigateGlobally(String routeName, {Object? arguments}) async {
//     if (navigatorKey.currentState != null) {
//       await navigatorKey.currentState!.push(_createRoute(routeName, arguments));
//     }
//     throw Exception("Global navigator is not available!");
//   }
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {

    switch (settings.name) {
      case Routes.categoriesRoute:
        return MaterialPageRoute(builder: (_) => CategoriesView());
      case Routes.locationRoute:
        final args = settings.arguments as Map;
        String id = "";
        String type = "";
        Map? arguments;
        if (args != null) {
          arguments = args;
          id = arguments["id"] ?? "";
          type = arguments["type"] ?? "";
        }
        return MaterialPageRoute(builder: (_) => LocationView(type: type, id: id,));

      case Routes.zoomRoute:
        final arguments = settings.arguments as Map;
        String url = arguments['url'];
        return MaterialPageRoute(builder: (_) =>  ZoomView(url: url,));
      case Routes.leaveReviewRoute:
        final arguments = settings.arguments as Map;
        ProductMyItemModel myItemModel = arguments['myItemModel'];
        return MaterialPageRoute(builder: (_) => LeaveReviewView(myItemModel: myItemModel,));
      case Routes.cartRoute:

        return MaterialPageRoute(builder: (_) =>  CartView());

      case Routes.selectAddressRoute:

        return MaterialPageRoute(builder: (_) =>  SelecetPaymentView());
      case Routes.checkOutRoute:
        final arguments = settings.arguments as Map;
        EstimateShippingMethod estimatedShippingMethod = arguments['estimatedShippingMethod'];
        ShippingInformationModel shippingInformationMethod= arguments['shippingInformationMethod'];
        AddressDomain addressDomain = arguments['addressDomain'];
        return MaterialPageRoute(builder: (_) =>  CheckOutView(estimatedShippingMethod: estimatedShippingMethod,shippingInformationMethod: shippingInformationMethod,addressDomain: addressDomain,));
      case Routes.paymentMethodRoute:
        final arguments = settings.arguments as Map;
        List<PaymentMethodInformationModel> paymentMethods = arguments['paymentMethods'];
        AddressDomain addressDomain = arguments['addressDomain'];


        return MaterialPageRoute(builder: (_) =>  PaymentMethodView(paymentMethods:paymentMethods,addressDomain: addressDomain,));

      case Routes.wishListRoute:

        return MaterialPageRoute(builder: (_) =>  WishlistView());
      case Routes.myHomeOffersRoute:
        final arguments = settings.arguments as Map;
        String categoryId = arguments['categoryId'];
        return MaterialPageRoute(builder: (_) =>  HomeCategoryWidget(categoryId: categoryId));
      case Routes.brandsProductsRoute:
        final arguments = settings.arguments as Map;
        String brandName = arguments['brandName'];
        String brandId = arguments['brandId'];
        return MaterialPageRoute(builder: (_) =>  BrandsProductsView(brandId: brandId,brandName: brandName,));

      case Routes.myOrdersRoute:

        return MaterialPageRoute(builder: (_) =>  MyOrdersView());
      case Routes.successRoute:
        final arguments = settings.arguments as Map;
        int orderId = arguments['orderId'];
        return MaterialPageRoute(builder: (_) =>  SuccessPayment(OrderId: orderId,));
      case Routes.privacyRoute:

        return MaterialPageRoute(builder: (_) =>  PrivacyView());
      case Routes.contactUsRoute:
        return MaterialPageRoute(builder: (_) => const ContactUsView());
      case Routes.countryRoute:
        return MaterialPageRoute(builder: (_) => const CountryView());

      case Routes.addressRoute:
        final arguments = settings.arguments as Map;
        bool fromCart = arguments['fromCart'];
        return MaterialPageRoute(builder: (_) =>  AddressesView(fromCart: fromCart,));
      case Routes.orderDetailsRoute:
        final arguments = settings.arguments as Map;
        MyItemModel myItemModel = arguments['myItemModel'];
        return MaterialPageRoute(builder: (_) =>  OrderDetailsView(myItemModel: myItemModel,));


      case Routes.addAddressRoute:
        return MaterialPageRoute(builder: (_) => const AddAddressView());

      case Routes.searchRoute:
        final arguments = settings.arguments as Map;
        String mSearchText = arguments['searchText'];
        return MaterialPageRoute(builder: (_) =>  SearchView(searchText: mSearchText,));
      case Routes.loadingRoute:
        return MaterialPageRoute(builder: (_) => const LoadingStates());
      case Routes.productsRoute:
        final arguments = settings.arguments as Map;
        String categoryName = arguments['categoryName'];
        String categoryId = arguments['categoryId'];
        return MaterialPageRoute(builder: (_) =>  ProductsView(categoryName: categoryName,categoryId: categoryId,));
      case Routes.productDetailsRoute:
        final arguments = settings.arguments as Map;
        ProductItemModel productModel = arguments['productDetails'];

        return MaterialPageRoute(builder: (_) =>  ProductDetailsView(productModel: productModel));
      case Routes.productDetailsHomeRoute:
        final arguments = settings.arguments as Map;
        String productId = arguments['productId'];

        return MaterialPageRoute(builder: (_) =>  ProductDetailsHomeView(productId: productId,));

      case Routes.statesRoute:
        final arguments = settings.arguments as Map;
        String countryCode = arguments['countryCode'];

        return MaterialPageRoute(builder: (_) =>  StatesView(countryCode: countryCode));
      case Routes.citiesRoute:
        final arguments = settings.arguments as Map;
        String stateName = arguments['stateName'];

        return MaterialPageRoute(builder: (_) =>  CitiesView(stateName: stateName));
      case Routes.addressDetailsRoute:
        final arguments = settings.arguments as Map;
        AddressDomain addressDomain = arguments['addressDomain'];

        return MaterialPageRoute(builder: (_) =>  AddressDetailsView(addressDomain: addressDomain));

      case Routes.subCategoriesHomeRoute:
        final arguments = settings.arguments as Map;
        CategoryComponentHome categoryModel = arguments['categoryModel'];
        return MaterialPageRoute(builder: (_) =>  SubCategoriesHomeView(categoryModel: categoryModel));


      case Routes.subCategoriesRoute:
        final arguments = settings.arguments as Map;
        CategoryModel categoryModel = arguments['categoryModel'];
        return MaterialPageRoute(builder: (_) =>  SubCategoriesView(categoryModel: categoryModel));
      case Routes.userProfileRoute:
        final arguments = settings.arguments as Map;
        UserInfoModel userInfoModel = arguments['userInfoModel'];
        return MaterialPageRoute(builder: (_) =>  EditProfileView(userInfoModel: userInfoModel));
      case Routes.setNewPasswordRoute:
        final arguments = settings.arguments as Map;
        UserInfoModel userInfoModel = arguments['userInfoModel'];
        return MaterialPageRoute(builder: (_) =>  SetNewPasswordView(userInfoModel: userInfoModel));

      case Routes.resetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ResetPasswordView());
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.mainRoute:


        String id ="";
        String type="";
        Map? arguments;
        if (settings.arguments != null && settings.arguments is Map) {
          arguments = settings.arguments as Map;
          id  = arguments["id"]??"";
          type = arguments["type"]??"";
        }


        return MaterialPageRoute(builder: (_) =>  MainView(type: type,id: id,));
      case Routes.paymentRoute:
        final arguments = settings.arguments as Map;
        String url = arguments['url'];
        String invoiceId = arguments['invoiceId'];
        String paymentMethod = arguments['paymentMethod'];
        double amount = arguments['amount'];
        return MaterialPageRoute(builder: (_) =>  PaymentView(url: url,invoiceId: invoiceId,paymentMethod: paymentMethod,amount: amount,));

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
