class SellProductModel {
  String spid; // sell pid
  String userid;
  String productName;
  double price;
  String description;
  String imageUrl;
  int contactNumber; // New field

  SellProductModel({
    required this.spid, // New field
    required this.userid,
    required this.productName,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.contactNumber,
  });

  factory SellProductModel.fromMap(Map<String, dynamic> map) {
    print(map["spid"]);
    return SellProductModel(
      spid: map['spid'] as String, // New field
      userid: map['userid'] as String,
      productName: map['productName'] as String,
      price: map['price'] as double,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      contactNumber: map['contactNumber'] as int, // New field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spid': spid, // New field
      'userid': userid,
      'productName': productName,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      'contactNumber': contactNumber, // New field
    };
  }
}
