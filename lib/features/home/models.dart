part of'../../../views/home/pages/home.dart';

class _ProductModel {
  late final int id;
  late final String name;
  late final String description;
  late final String imageUrl;
  late final double price;
  late final int stock;
  late final int categoryId;

  _ProductModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      description = json['description'],
      imageUrl = json['imageUrl'],
      price = json['price'],
      stock = json['stock'],
      categoryId = json['categoryId']??0;
}

class _SliderModel {
  late final int id;
  late final String couponCode;
  late final int discountPercent;
  late final String descriptionTitle1;
  late final String descriptionTitle2;
  late final String imageUrl;

  _SliderModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    couponCode = json['couponCode'];
    discountPercent = json['discountPercent'];
    descriptionTitle1 = json['descriptionTitle1'];
    descriptionTitle2 = json['descriptionTitle2'];
    imageUrl = json['imageUrl'];
  }

}
