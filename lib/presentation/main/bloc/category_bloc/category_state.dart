import 'package:equatable/equatable.dart';

/// Bloc State
class CategoryState extends Equatable {
  final int? expandedParentCategoryId;

  const CategoryState({this.expandedParentCategoryId});

  @override
  List<Object?> get props => [expandedParentCategoryId];
}