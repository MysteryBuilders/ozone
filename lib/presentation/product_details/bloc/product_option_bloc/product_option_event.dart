import '../../../../domain/model/bundle_product_options_model.dart';

abstract class ProductOptionEvent {}

class InitProductOptions extends ProductOptionEvent {
  final List<BundleProductOptionsModel> options;

  InitProductOptions(this.options);
}

class SelectOptionItem extends ProductOptionEvent {
  final int optionId;
  final String selectedLinkId;

  SelectOptionItem({required this.optionId, required this.selectedLinkId});
}
