import 'package:ozon/app/constants.dart';

import '../../domain/model/home_screen_model.dart';
import '../response/home_screen_response.dart';

extension ScreenMapper on Screen? {
  ScreenHome toDomain() {
    return ScreenHome(
      screenId: this?.screenId ?? '',
      name: this?.name ?? '',
      components: this?.components.map((component) => component.toDomain()).toList() ?? [],
    );
  }
}
extension ComponentMapper on Component? {
  ComponentHome toDomain() {
    dynamic componentData;

    switch (this?.type) {
      case 'slider_component_di':
        componentData = (this?.componentData as List<SliderComponentData>?)
            ?.map((item) => item.toDomain())
            .toList();
        break;
      case 'two_banner_component_di':
        componentData = (this?.componentData as List<SliderComponentData>?)
            ?.map((item) => item.toDomain())
            .toList();
        break;
      case 'four_banner_component_di':
        componentData = (this?.componentData as List<SliderComponentData>?)
            ?.map((item) => item.toDomain())
            .toList();
        break;
      case 'before_after_filter_banner_component_di':

        componentData = (this?.componentData as List<SliderComponentData>?)
            ?.map((item) => item.toDomain())
            .toList();
        break;
      case 'category_component_di':
        componentData = (this?.componentData as List<CategoryComponent>?)
            ?.map((item) => item.toDomain())
            .toList();
        // componentData = (this?.componentData as CategoryComponentData?)?.toDomain();
        break;
      case 'products_component_di':
        componentData = (this?.componentData as List<ProductComponentData>?)
            ?.map((item) => item.toDomain())
            .toList();
        break;
      case 'brands_component_di':
        componentData = (this?.componentData as List<Brand>?)
            ?.map((item) => item.toDomain())
            .toList();
        break;
      case 'banner_component_di':
        componentData = (this?.componentData as List<SliderComponentData>?)
            ?.map((item) => item.toDomain())
            .toList();
        break;
      default:
        componentData = null;
        break;
    }

    return ComponentHome(
      componentId: this?.componentId ?? '',
      screenId: this?.screenId ?? '',
      sortId: this?.sortId ?? '',
      type: this?.type ?? '',
      componentData: componentData,
      timer: this?.timer ?? 0,
    );
  }
}
extension SliderComponentDataMapper on SliderComponentData? {
  SliderComponentDataHome toDomain() {
    return SliderComponentDataHome(
      image: this?.image ?? '',
      categoryId: this?.categoryId ?? '',
    );
  }
}

extension CategoryComponentDataMapper on CategoryComponentData? {
  CategoryComponentDataHome toDomain() {
    return CategoryComponentDataHome(
      categoryComponent: this?.categoryComponent.map((category) => category.toDomain()).toList() ?? [],
    );
  }
}

extension CategoryComponentMapper on CategoryComponent? {
  CategoryComponentHome toDomain() {
    return CategoryComponentHome(
      title: this?.title ?? '',
      categoryId: this?.categoryId ?? '',
      children: this?.children.map((child) => child.toDomain()).toList() ?? [],
    );
  }
}

extension CategoryChildMapper on CategoryChild? {
  CategoryChildHome toDomain() {
    return CategoryChildHome(
      categoryId: this?.categoryId ?? '',
      name: this?.name ?? '',
      image: this?.image ?? '',
    );
  }
}
extension ProductComponentDataMapper on ProductComponentData? {
  ProductComponentDataHome toDomain() {
    return ProductComponentDataHome(
      title: this?.title ?? '',
      collectionFilter: this?.collectionFilter ?? '',
      initialize: this?.initialize,
      // bestSellerProducts: this?.bestSellerProducts?.map((product) => product.toDomain()).toList(),
      // offersProducts: this?.offersProducts?.map((product) => product.toDomain()).toList(),
      newArrivalProducts: this?.newArrivalProducts?.map((product) => product.toDomain()).toList(),
    );
  }
}

extension ProductMapper on Product? {
  ProductHome toDomain() {
    return ProductHome(
      productId: this?.productId ?? '',
      name: this?.name ?? '',
      price: this?.price ?? '',
      specialPrice: this?.specialPrice,
      image: this?.image ?? '',
      url: this?.url ?? '',
      discount: this?.discount ?? '',
      isWishlisted: this?.isWishlisted ?? '',
      sku: this?.sku ?? '',
      salableQty: this?.salableQty??Constants.zero,
      onSale: this?.onSale??''
    );
  }
}
extension BrandComponentDataMapper on BrandComponentData? {
  BrandComponentDataHome toDomain() {
    return BrandComponentDataHome(
      title: this?.title ?? '',
      type: this?.type ?? '',
      featuredBrands: this?.featuredBrands.map((brand) => brand.toDomain()).toList() ?? [],
    );
  }
}

extension BrandMapper on Brand? {
  BrandHome toDomain() {
    return BrandHome(
      label: this?.label ?? '',
      url: this?.url ?? '',
      thumbnail: this?.thumbnail ?? '',
    );
  }
}



