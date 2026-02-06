class SortingOptionModel{
  String sortName;
  String sortCode;
  SortingOptionModel(this.sortName,this.sortCode);
}
class SortingCategoryModel{
  List<SortingOptionModel>? sortOptionList;
  List<AvailableFilterModel>? availableFilterList;
  SortingCategoryModel(this.sortOptionList,this.availableFilterList);
}
class FilterOptionModel{
  String name;
  String filterId;
  int count;
  FilterOptionModel(this.name,this.filterId,this.count);

}

class AvailableFilterModel{
   String? filterName;


   String? filterCode;


   String? filterType;

  List<FilterOptionModel>? filterOptionList;


   int? minPrice;


   int? maxPrice;


   AvailableFilterModel(this.filterName,this.filterCode,
       this.filterType,this.filterOptionList,this.minPrice,this.maxPrice);
}