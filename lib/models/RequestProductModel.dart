class RequestProductModel {
  String rpid; // request pid
  String userid;
  String productName;
  double price;
  String description;

  RequestProductModel({
    required this.rpid, // New field
    required this.userid,
    required this.productName,
    required this.price,
    required this.description,
  });

  factory RequestProductModel.fromMap(Map<String, dynamic> map) {
    return RequestProductModel(
      rpid: map['rpid'] as String, // New field
      userid: map['userid'] as String,
      productName: map['productName'] as String,
      price: map['price'] as double,
      description: map['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rpid': rpid, // New field
      'userid': userid,
      'productName': productName,
      'price': price,
      'description': description,
    };
  }
}
