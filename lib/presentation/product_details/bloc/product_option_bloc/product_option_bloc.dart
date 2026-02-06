import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozon/presentation/product_details/bloc/product_option_bloc/product_option_event.dart';
import 'package:ozon/presentation/product_details/bloc/product_option_bloc/product_option_state.dart';

class ProductOptionBloc extends Bloc<ProductOptionEvent, ProductOptionState> {
  ProductOptionBloc() : super(ProductOptionState(options: [], selectedItems: {})) {
    on<InitProductOptions>((event, emit) {
      final defaultSelections = <int, String>{};
      for (var option in event.options) {
        final defaultLink = option.productLinks!.firstWhere((p) => p.isDefault!, orElse: () => option.productLinks!.first);
        defaultSelections[option.optionId!] = defaultLink.id!;
      }
      emit(ProductOptionState(options: event.options, selectedItems: defaultSelections));
    });

    on<SelectOptionItem>((event, emit) {
      final updated = Map<int, String>.from(state.selectedItems);
      updated[event.optionId] = event.selectedLinkId;
      emit(state.copyWith(selectedItems: updated));
    });
  }
}
