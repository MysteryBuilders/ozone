
import 'package:flutter/material.dart';
import 'package:ozon/presentation/brands/view/brands_view.dart';
import 'package:ozon/presentation/main/view/cart_view.dart';
import 'package:ozon/presentation/main/view/categories_view.dart';
import 'package:ozon/presentation/main/view/offers_view.dart';
import 'package:ozon/presentation/main/view/profile_view.dart';

import 'home_view.dart';

class TabNavigator {
  static final List<Widget> tabs = [
    HomeView(),
    CategoriesView(),
    // CartView(),
    BrandsView(),
    ProfileView()
  ];
}