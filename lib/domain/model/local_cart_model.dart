// Cart Model
import 'order_model.dart';

class LocalCartModel {
  final List<OrderItemModel> items;

  LocalCartModel({this.items = const []});

  int get itemCount => items.length;
}
