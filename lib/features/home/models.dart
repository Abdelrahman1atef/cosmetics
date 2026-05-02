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
    : id = json['id'] ?? 0,
      name = json['name_en'] ?? json['name_ar'] ?? json['name'] ?? "",
      description = json['description_en'] ?? json['description_ar'] ?? json['description'] ?? "",
      imageUrl = json['image_url'] ?? json['imageUrl'] ?? "",
      price = (json['price'] ?? 0).toDouble(),
      stock = json['stock'] ?? 0,
      categoryId = json['category_id'] ?? json['categoryId'] ?? 0;
}

class _SliderModel {
  late final int id;
  late final String couponCode;
  late final int discountPercent;
  late final String descriptionTitle1;
  late final String descriptionTitle2;
  late final String imageUrl;

  _SliderModel.fromJson(Map<String, dynamic> json){
    id = json['id'] ?? 0;
    couponCode = json['coupon_code'] ?? json['couponCode'] ?? "";
    discountPercent = json['discount_percent'] ?? json['discountPercent'] ?? 0;
    descriptionTitle1 = json['description_title1_en'] ?? json['description_title1_ar'] ?? json['descriptionTitle1'] ?? "";
    descriptionTitle2 = json['description_title2_en'] ?? json['description_title2_ar'] ?? json['descriptionTitle2'] ?? "";
    imageUrl = json['image_url'] ?? json['imageUrl'] ?? "";
  }
}
