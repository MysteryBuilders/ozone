import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(const CategoryState()) {
    on<ExpandParentCategory>((event, emit) {
      if (state.expandedParentCategoryId == event.categoryId) {
        // Collapse if already expanded
        emit(const CategoryState(expandedParentCategoryId: null));
      } else {
        // Expand the new parent category and collapse others
        emit(CategoryState(expandedParentCategoryId: event.categoryId));
      }
    });
  }
}