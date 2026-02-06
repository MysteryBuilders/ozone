class ProductModel{

  int? id;

  String? sku;

  String? name;

  double? price;

  int? status;

  int? visibility;

  String? typeId;

  String? createdAt;

  String? updatedAt;

  List<CustomAttributeModel>? customAttributes;


  List<MediaGalleryEntryModel>? mediaGalleryEntries;

  ProductModel({
    required this.id,
    required this.sku,
    required this.name,
    required this.price,
    required this.status,
    required this.visibility,
    required this.typeId,
    required this.createdAt,
    required this.updatedAt,
    required this.customAttributes,
    required this.mediaGalleryEntries,
  });


}

class CustomAttributeModel {

  String? attributeCode;

  dynamic? value;

  CustomAttributeModel({
    required this.attributeCode,
    required this.value,
  });


}


class MediaGalleryEntryModel {

  int? id;

  String? mediaType;

  String? file;

  MediaGalleryEntryModel({
    required this.id,
    required this.mediaType,
    required this.file,
  });


}

class SearchCriteriaModel {

  List<FilterGroupModel>? filterGroups;

  SearchCriteriaModel({required this.filterGroups});


}


class FilterGroupModel {

  List<FilterModel>? filters;

  FilterGroupModel({required this.filters});


}


class FilterModel {

  String? field;

  String? value;

  String? conditionType;

  FilterModel({
    required this.field,
    required this.value,
    required this.conditionType,
  });


}

class ProductsModel {

  List<ProductModel>? items;

  SearchCriteriaModel? searchCriteria;

  int? totalCount;

  ProductsModel({
    required this.items,
    required this.searchCriteria,
    required this.totalCount,
  });


}
