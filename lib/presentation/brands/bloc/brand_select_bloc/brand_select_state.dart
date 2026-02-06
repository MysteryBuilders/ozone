part of 'brand_select_bloc.dart';

sealed class BrandSelectState extends Equatable {
  const BrandSelectState();
}

final class BrandSelectInitial extends BrandSelectState {
  @override
  List<Object> get props => [];
}

class BrandSelectSuccess extends BrandSelectState {
  final int index;

  BrandSelectSuccess({required this.index});

  @override
  List<Object> get props => [index];
}