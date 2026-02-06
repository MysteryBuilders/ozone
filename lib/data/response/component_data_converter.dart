// component_data_converter.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:ozon/data/response/home_screen_response.dart';


class ComponentDataConverter implements JsonConverter<dynamic, Object?> {
  const ComponentDataConverter();

  @override
  dynamic fromJson(Object? json, [String? type]) {
    if (json == null) {
      return null;
    }

    if (type == null) {
      throw ArgumentError('Type is required for deserialization');
    }
    print(type);

    switch (type) {

      case 'slider_component_di':


        return (json as List)
            .map((e) => SliderComponentData.fromJson(e as Map<String, dynamic>))
            .toList();
      case 'before_after_filter_banner_component_di':
        return (json as List)
            .map((e) => SliderComponentData.fromJson(e as Map<String, dynamic>))
            .toList();
      case 'two_banner_component_di':
        return (json as List)
            .map((e) => SliderComponentData.fromJson(e as Map<String, dynamic>))
            .toList();
      case 'four_banner_component_di':
        return (json as List)
            .map((e) => SliderComponentData.fromJson(e as Map<String, dynamic>))
            .toList();
      case 'category_component_di':
        return (json as List)
            .map((e) => CategoryComponent.fromJson(e as Map<String, dynamic>))
            .toList();
        // return CategoryComponentData.fromJson(json as Map<String, dynamic>);
      case 'products_component_di':
        return (json as List)
            .map((e) => ProductComponentData.fromJson(e as Map<String, dynamic>))
            .toList();
      case 'brands_component_di':
        return (json as List)
            .map((e) => Brand.fromJson(e as Map<String, dynamic>))
            .toList();
      case 'banner_component_di':
        return (json as List)
            .map((e) => SliderComponentData.fromJson(e as Map<String, dynamic>))
            .toList();
      default:
        return json;
    }
  }

  @override
  Object? toJson(dynamic object) {
    if (object == null) {
      return null;
    }
    if (object is List) {
      return object.map((e) => e.toJson()).toList();
    } else if (object is Component) {
      return object.toJson();
    } else {
      return object;
    }
  }
}
