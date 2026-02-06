
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ozon/app/constants.dart';
import 'package:ozon/presentation/addresses/bloc/addresses_bloc.dart';
import 'package:ozon/presentation/country/bloc/country_bloc.dart';
import 'package:ozon/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:ozon/presentation/login/bloc/login_bloc.dart';
import 'package:ozon/presentation/main/bloc/add_to_cart/add_to_cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/cart_bloc/cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/cart_local/cart_local_bloc.dart';
import 'package:ozon/presentation/main/bloc/categories_bloc/categories_bloc.dart';
import 'package:ozon/presentation/main/bloc/delete_item_cart/delete_item_cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/home_bloc/home_bloc.dart';
import 'package:ozon/presentation/main/bloc/main_bloc/main_bloc.dart';
import 'package:ozon/presentation/main/bloc/offers_bloc/load_more_bloc.dart';
import 'package:ozon/presentation/main/bloc/update_cart/update_cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/user_bloc/user_bloc.dart';
import 'package:ozon/presentation/product_details/bloc/counter_bloc.dart';
import 'package:ozon/presentation/product_details/bloc/stock_info_bloc.dart';
import 'package:ozon/presentation/products/bloc/products_bloc.dart';
import 'package:ozon/presentation/register/bloc/register_bloc.dart';
import 'package:ozon/presentation/set_new_password/bloc/set_new_password_bloc.dart';

import 'package:ozon/presentation/splash/bloc/notification_bloc/notification_bloc.dart';

import 'package:ozon/presentation/splash/bloc/splash_bloc/splash_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../presentation/forget_password/bloc/forget_password_bloc.dart';
import '../presentation/language/bloc/language_bloc.dart';
import '../presentation/language/bloc/language_event.dart';
import '../presentation/language/bloc/language_state.dart';
import '../presentation/product_details/bloc/caursel_bloc.dart';
import '../presentation/resources/langauge_manager.dart';
import '../presentation/resources/routes_manager.dart';
import '../presentation/resources/theme_manager.dart';
import 'app_prefrences.dart';
import 'di.dart';

class MyApp extends StatefulWidget {


  //named Constructor
  MyApp._internal();

  int appState = 0;
  static final MyApp _instance = MyApp
      ._internal(); // singleTon or single instance
  factory MyApp() => _instance; // factory;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  bool isBackButtonActivated = false;

  LocalizationBloc localizationBloc = GetIt.I<LocalizationBloc>();

  bool? isSwitchOn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,


      minTextAdapt: true,


      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (context, child) {
        return BlocBuilder<LocalizationBloc, LocalizationState>(
          bloc: localizationBloc..add(DefaultLocale(ARABIC_LOCAL,context)),
          builder: (context, state) {
            return MaterialApp(


              scrollBehavior: MyCustomScrollBehavior(),


              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: state.locale,


              debugShowCheckedModeBanner: false,

              onGenerateRoute: RouteGenerator.getRoute,
              initialRoute: Routes.splashRoute,

              theme: getApplicationTheme(),
            );
          },
        );
      },

    );
  }

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    isSwitchOn = prefs.getBool('isDriverOn') ?? false;
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child,
      ScrollableDetails details) {
    return child;
  }
}
