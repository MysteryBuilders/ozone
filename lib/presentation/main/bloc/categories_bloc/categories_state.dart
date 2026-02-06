

import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/register_model.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final CategoryModel categoryModel;

  const CategoriesSuccess({required this.categoryModel});

  @override
  List<Object> get props => [categoryModel];
}

class CategoriesFailure extends CategoriesState {
  final String message;

  const CategoriesFailure({required this.message});

  @override
  List<Object> get props => [message];
}
