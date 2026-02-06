import 'dart:convert';

class HomeModel {
  List<HorizonLayout>? horizonLayout;
  Setting? setting;
  List<TabBar>? tabBar;

  Drawer? drawer;
  int? version;
  String? datetime;

  HomeModel({
    this.horizonLayout,
    this.setting,
    this.tabBar,

    this.drawer,
    this.version,
    this.datetime,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      horizonLayout: json['HorizonLayout'] != null
          ? List<HorizonLayout>.from(json['HorizonLayout'].map((x) => HorizonLayout.fromJson(x)))
          : null,
      setting: json['Setting'] != null ? Setting.fromJson(json['Setting']) : null,
      tabBar: json['TabBar'] != null
          ? List<TabBar>.from(json['TabBar'].map((x) => TabBar.fromJson(x)))
          : null,

      drawer: json['Drawer'] != null ? Drawer.fromJson(json['Drawer']) : null,
      version: json['Version'],
      datetime: json['Datetime'],
    );
  }
}

class HorizonLayout {
  String? layout;
  bool? showMenu;
  bool? showSearch;
  bool? showLogo;
  String? image;
  int? pos;
  List<Items>? items;
  String? name;
  int? category;
  bool? wrap;
  int? size;
  int? radius;
  String? design;
  bool? isSlider;
  bool? isHorizontal;
  bool? enableParallax;
  double? parallaxImageRatio;
  int? padding;
  int? marginLeft;
  int? marginRight;
  int? marginBottom;
  int? marginTop;
  bool? parallax;
  String? fit;
  String? type;

  HorizonLayout({
    this.layout,
    this.showMenu,
    this.showSearch,
    this.showLogo,
    this.image,
    this.pos,
    this.items,
    this.name,
    this.category,
    this.wrap,
    this.size,
    this.radius,
    this.design,
    this.isSlider,
    this.isHorizontal,
    this.enableParallax,
    this.parallaxImageRatio,
    this.padding,
    this.marginLeft,
    this.marginRight,
    this.marginBottom,
    this.marginTop,
    this.parallax,
    this.fit,
    this.type,
  });

  factory HorizonLayout.fromJson(Map<String, dynamic> json) {
    return HorizonLayout(
      layout: json['layout'],
      showMenu: json['showMenu'],
      showSearch: json['showSearch'],
      showLogo: json['showLogo'],
      image: json['image'],
      pos: json['pos'],
      items: json['items'] != null
          ? List<Items>.from(json['items'].map((x) => Items.fromJson(x)))
          : null,
      name: json['name'],
      category: json['category'],
      wrap: json['wrap'],
      size: json['size'],
      radius: json['radius'],
      design: json['design'],
      isSlider: json['isSlider'],
      isHorizontal: json['isHorizontal'],
      enableParallax: json['enableParallax'],
      parallaxImageRatio: json['parallaxImageRatio'],
      padding: json['padding'],
      marginLeft: json['marginLeft'],
      marginRight: json['marginRight'],
      marginBottom: json['marginBottom'],
      marginTop: json['marginTop'],
      parallax: json['parallax'],
      fit: json['fit'],
      type: json['type'],
    );
  }
}

class Items {
  int? category;
  String? image;
  List<String>? colors;
  bool? originalColor;
  int? padding;

  Items({
    this.category,
    this.image,
    this.colors,
    this.originalColor,
    this.padding,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      category: json['category'],
      image: json['image'],
      colors: json['colors'] != null
          ? List<String>.from(json['colors'])
          : null,
      originalColor: json['originalColor'],
      padding: json['padding'],
    );
  }
}

class Setting {
  String? tabBarConfig;
  String? fontFamily;
  String? fontHeader;
  String? mainColor;
  bool? showChat;
  String? productListLayout;
  bool? stickyHeader;

  Setting({
    this.tabBarConfig,
    this.fontFamily,
    this.fontHeader,
    this.mainColor,
    this.showChat,
    this.productListLayout,
    this.stickyHeader,
  });

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      tabBarConfig: json['TabBarConfig'],
      fontFamily: json['FontFamily'],
      fontHeader: json['FontHeader'],
      mainColor: json['MainColor'],
      showChat: json['ShowChat'],
      productListLayout: json['ProductListLayout'],
      stickyHeader: json['StickyHeader'],
    );
  }
}

class TabBar {
  String? layout;
  String? icon;
  int? pos;
  int? category;
  bool? showChat;
  String? categoryLayout;

  TabBar({
    this.layout,
    this.icon,
    this.pos,
    this.category,
    this.showChat,
    this.categoryLayout,
  });

  factory TabBar.fromJson(Map<String, dynamic> json) {
    return TabBar(
      layout: json['layout'],
      icon: json['icon'],
      pos: json['pos'],
      category: json['category'],
      showChat: json['showChat'],
      categoryLayout: json['categoryLayout'],
    );
  }
}

class AppBar {}

class Drawer {
  int? filter;
  LogoConfig? logoConfig;
  bool? enable;
  String? logo;

  bool? safeArea;
  List<DrawerItems>? items;
  String? key;

  Drawer({
    this.filter,
    this.logoConfig,
    this.enable,
    this.logo,

    this.safeArea,
    this.items,
    this.key,
  });

  factory Drawer.fromJson(Map<String, dynamic> json) {
    return Drawer(
      filter: json['filter'],
      logoConfig: json['logoConfig'] != null
          ? LogoConfig.fromJson(json['logoConfig'])
          : null,
      enable: json['enable'],
      logo: json['logo'],

      safeArea: json['safeArea'],
      items: json['items'] != null
          ? List<DrawerItems>.from(json['items'].map((x) => DrawerItems.fromJson(x)))
          : null,
      key: json['key'],
    );
  }
}

class LogoConfig {
  int? marginRight;
  bool? useMaxWidth;
  int? width;
  String? boxFit;
  int? marginBottom;
  int? marginTop;
  int? height;
  int? marginLeft;

  LogoConfig({
    this.marginRight,
    this.useMaxWidth,
    this.width,
    this.boxFit,
    this.marginBottom,
    this.marginTop,
    this.height,
    this.marginLeft,
  });

  factory LogoConfig.fromJson(Map<String, dynamic> json) {
    return LogoConfig(
      marginRight: json['marginRight'],
      useMaxWidth: json['useMaxWidth'],
      width: json['width'],
      boxFit: json['boxFit'],
      marginBottom: json['marginBottom'],
      marginTop: json['marginTop'],
      height: json['height'],
      marginLeft: json['marginLeft'],
    );
  }
}

class DrawerItems {
  bool? show;
  String? type;

  DrawerItems({
    this.show,
    this.type,
  });

  factory DrawerItems.fromJson(Map<String, dynamic> json) {
    return DrawerItems(
      show: json['show'],
      type: json['type'],
    );
  }
}

class SubDrawerItem {}

