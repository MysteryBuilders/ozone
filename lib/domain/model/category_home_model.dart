class CategroyItemModel{
  final String categoryId;

  final String categoryImage;
  CategroyItemModel({
    required this.categoryId,
    required this.categoryImage,
  });
}
class SearchCriteriaModel{
  final List<dynamic> filterGroups;

  final int pageSize;
  SearchCriteriaModel({
    required this.filterGroups,
    required this.pageSize,
  });
}
class CategoryHomeModel{
  final List<CategroyItemModel> items;

  final SearchCriteriaModel searchCriteria;

  final int totalCount;

  CategoryHomeModel({
    required this.items,
    required this.searchCriteria,
    required this.totalCount,
  });
}