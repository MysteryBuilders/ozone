// Domain model for Screen
class ScreenDomain {
  final String id;
  final String name;
  final List<ComponentDomain> components;

  ScreenDomain({
    required this.id,
    required this.name,
    required this.components,
  });
}

// Domain model for Component
class ComponentDomain {
  final String id;
  final String screenId;
  final String sortId;
  final String type;
  final dynamic data;  // Can vary depending on the component type

  ComponentDomain({
    required this.id,
    required this.screenId,
    required this.sortId,
    required this.type,
    required this.data,
  });
}

// Domain model for Slider Component
class SliderComponentDomain {
  final String imageUrl;
  final String categoryId;

  SliderComponentDomain({
    required this.imageUrl,
    required this.categoryId,
  });
}

class CategoryComponentListData {

  final List<CategoryComponentDomain> categoryComponentDomainList;

  CategoryComponentListData({required this.categoryComponentDomainList});

 }

// Domain model for Category Component
class CategoryComponentDomain {
  final String title;
  final String categoryId;
  final List<CategoryChildDomain> children;

  CategoryComponentDomain({
    required this.title,
    required this.categoryId,
    required this.children,
  });
}

// Domain model for Category Child
class CategoryChildDomain {
  final String id;
  final String name;
  final String imageUrl;

  CategoryChildDomain({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}

// Domain model for Product (Best Seller)
class ProductDomain {
  final String id;
  final String name;
  final String price;
  final String? specialPrice;
  final String imageUrl;
  final String url;
  final String discount;
  final String isWishlisted;
  final String sku;

  ProductDomain({
    required this.id,
    required this.name,
    required this.price,
    this.specialPrice,
    required this.imageUrl,
    required this.url,
    required this.discount,
    required this.isWishlisted,
    required this.sku,
  });
}

// Domain model for Brand
class BrandDomain {
  final String label;
  final String url;
  final String thumbnailUrl;

  BrandDomain({
    required this.label,
    required this.url,
    required this.thumbnailUrl,
  });
}
