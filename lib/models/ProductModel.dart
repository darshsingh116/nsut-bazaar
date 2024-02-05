// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductModel {
  String productName;
  double price;
  String description;

  ProductModel({
    required this.productName,
    required this.price,
    required this.description,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productName: map['productName'] as String,
      price: map['price'] as double,
      description: map['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'price': price,
      'description': description,
    };
  }
}
