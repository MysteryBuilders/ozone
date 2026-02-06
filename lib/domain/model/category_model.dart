class CategoryModel{

  int? id;

  int? parentId;

  String? name;
  String? image;

  bool? isActive;

  int? position;

  int? level;

  int? productCount;

  List<CategoryModel> childrenData;
  CategoryModel(this.id,this.parentId,this.name,this.image,this.isActive,this.position,this.level,this.productCount,this.childrenData);
}