import 'package:ozon/data/response/home_screen_response.dart';
import 'package:ozon/data/response/component_data_converter.dart';

/// Parses a Component from JSON using ComponentDataConverter
Component parseComponent(Map<String, dynamic> json) {
  final String type = json['type'] ?? '';
  final dynamic rawData = json['component_data'];

  final dynamic parsedComponentData =
  const ComponentDataConverter().fromJson(rawData, type);

  return Component(
    componentId: json['component_id'] as String,
    screenId: json['screen_id'] as String,
    sortId: json['sort_id'] as String,
    type: type,
    componentData: parsedComponentData,
    timer: json['timer'] as int,
  );
}

/// Parses a Screen from JSON using parseComponent to handle component_data
Screen parseScreen(Map<String, dynamic> json) {
  final List<Component> components = (json['components'] as List)
      .map((e) => parseComponent(e as Map<String, dynamic>))
      .toList();

  return Screen(
    screenId: json['screen_id'] as String,
    name: json['name'] as String,
    components: components,
  );
}

/// Parses a list of screens
List<Screen> parseScreenList(List<dynamic> jsonList) {
  return jsonList.map((json) => parseScreen(json as Map<String, dynamic>)).toList();
}
