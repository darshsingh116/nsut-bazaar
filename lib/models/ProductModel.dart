
class ProductModel {
  String userid; // Renamed parameter

  String productName;
  double price;
  String description;

  ProductModel({
    required this.userid, // Updated constructor
    required this.productName,
    required this.price,
    required this.description,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      userid: map['userid'] as String, // Updated fromMap method
      productName: map['productName'] as String,
      price: map['price'] as double,
      description: map['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userid, // Updated toJson method
      'productName': productName,
      'price': price,
      'description': description,
    };
  }
}
