import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Expand Parent Category Event
class ExpandParentCategory extends CategoryEvent {
  final int categoryId;

  ExpandParentCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
