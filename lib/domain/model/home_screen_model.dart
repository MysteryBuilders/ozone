class BrandHome {

  final String label;


  final String url;


  final String thumbnail;

  BrandHome({required this.label, required this.url, required this.thumbnail});


}


class ProductHome {

  final String productId;


  final String name;


  final String price;


  final String? specialPrice;


  final String image;


  final String url;


  final String discount;


  final String isWishlisted;


  final String sku;
  final int salableQty;
  final String onSale;

  ProductHome({
    required this.productId,
    required this.name,
    required this.price,
    this.specialPrice,
    required this.image,
    required this.url,
    required this.discount,
    required this.isWishlisted,
    required this.sku,
    required this.salableQty,
    required this.onSale
  });


}

class CategoryChildHome {

  final String categoryId;


  final String name;


  final String image;

  CategoryChildHome({required this.categoryId, required this.name, required this.image});


}

class CategoryComponentHome {

  final String title;


  final String categoryId;


  final List<CategoryChildHome> children;

  CategoryComponentHome({required this.title, required this.categoryId, required this.children});


}

class CategoryComponentDataHome {

  final List<CategoryComponentHome> categoryComponent;

  CategoryComponentDataHome({required this.categoryComponent});


}

class SliderComponentDataHome {

  final String image;


  final String categoryId;

  SliderComponentDataHome({required this.image, required this.categoryId});


}


class ComponentHome {

  final String componentId;


  final String screenId;


  final String sortId;


  final String type;


  final dynamic componentData;


  final int timer;

  ComponentHome({
    required this.componentId,
    required this.screenId,
    required this.sortId,
    required this.type,
    required this.componentData,
    required this.timer
  });


}

class ScreenHome {

  final String screenId;


  final String name;


  final List<ComponentHome> components;

  ScreenHome({required this.screenId, required this.name, required this.components});


}

class ProductComponentDataHome {
  final String title;
  final String collectionFilter;
  final String? initialize;

  // Depending on which products list is populated, you can use one of these:
  // final List<ProductHome>? bestSellerProducts;
  // final List<ProductHome>? offersProducts;
  final List<ProductHome>? newArrivalProducts;

  ProductComponentDataHome({
    required this.title,
    required this.collectionFilter,
    this.initialize,
    // this.bestSellerProducts,
    // this.offersProducts,
    this.newArrivalProducts,
  });
}
class BrandComponentDataHome {
  final String title;
  final String type;
  final List<BrandHome> featuredBrands;

  BrandComponentDataHome({
    required this.title,
    required this.type,
    required this.featuredBrands,
  });
}