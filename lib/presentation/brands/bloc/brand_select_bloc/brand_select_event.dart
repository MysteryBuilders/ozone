part of 'brand_select_bloc.dart';

sealed class BrandSelectEvent extends Equatable {
  const BrandSelectEvent();
}
class BrandsSelectFetched extends BrandSelectEvent {
  final int index;


  const BrandsSelectFetched(this.index);

  @override
  List<Object> get props => [index];
}