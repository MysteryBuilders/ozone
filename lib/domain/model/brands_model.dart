class BrandItemModel {

  String? brand_id;

  String? brand_name;

  String? brand_img;

  int? products_count;
  BrandItemModel(this.brand_id,this.brand_name,this.brand_img,this.products_count);
  }

class BrandsDataModel {

  String? title;

  List<BrandItemModel>? brandsList;
  BrandsDataModel(this.title,this.brandsList);
 

}