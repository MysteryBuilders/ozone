import '../../../../domain/model/bundle_product_options_model.dart';

class ProductOptionState {
  final List<BundleProductOptionsModel> options;
  final Map<int, String> selectedItems; // key: optionId, value: selected productLinkId

  ProductOptionState({required this.options, required this.selectedItems});

  ProductOptionState copyWith({
    List<BundleProductOptionsModel>? options,
    Map<int, String>? selectedItems,
  }) {
    return ProductOptionState(
      options: options ?? this.options,
      selectedItems: selectedItems ?? this.selectedItems,
    );
  }
}
