class CustomerAttributeItemModel {

  String? attributeCode;

  String? value;


  CustomerAttributeItemModel(this.attributeCode,this.value);


}

class ProductItemModel {

  int? id;

  String? sku;

  String? name;

  int? attributeSetId;

  double? price;

  int? status;

  int? visibility;

  String? typeId;

  String? created_at;

  String? updated_at;

  List<CustomerAttributeItemModel>? customerAttributeList;
  ProductItemModel(this.id,this.sku,this.name,this.attributeSetId,this.price,
      this.status,this.visibility,this.typeId,this.created_at,this.updated_at,this.customerAttributeList);
  // from json



}

class WishListItemsModel {

  int? id;

  int? qty;


  ProductItemModel? productItemModel;

  WishListItemsModel(this.id,this.qty,this.productItemModel);


}

class WishListModel {

  int? customer_id;

  String? sharing_code;

  int? items_count;

  List<WishListItemsModel>? wishList;

  WishListModel(this.customer_id,this.sharing_code,this.items_count,this.wishList);


}