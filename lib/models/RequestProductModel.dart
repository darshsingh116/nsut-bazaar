class RequestProductModel {
  String rpid; // request pid
  String userid;
  String productName;
  double price;
  String description;
  String timestamp; // New field

  RequestProductModel({
    required this.rpid, // New field
    required this.userid,
    required this.productName,
    required this.price,
    required this.description,
    required this.timestamp, // New field
  });

  factory RequestProductModel.fromMap(Map<String, dynamic> map) {
    return RequestProductModel(
      rpid: map['rpid'] as String, // New field
      userid: map['userid'] as String,
      productName: map['productName'] as String,
      price: map['price'] as double,
      description: map['description'] as String,
      timestamp: map['timestamp'] as String, // New field
    );
  }

  Map<String, dynamic> toJson() {
    
    return {
      'rpid': rpid, // New field
      'userid': userid,
      'productName': productName,
      'price': price,
      'description': description,
      'timestamp': timestamp, // New field
    };
  }
}
