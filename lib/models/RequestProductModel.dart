import 'package:nsutbazaar/utils/random.dart';

class RequestProductModel {
  String rpid; // request pid
  String userid;
  String productName;
  double price;
  String description;
  String timestamp; // New field
  int contact; // Updated field
  String profileImg; // New field
  bool isAnonymous; // New field
  String username; // New field

  RequestProductModel({
    required this.rpid, // New field
    required this.userid,
    required this.productName,
    required this.price,
    required this.description,
    required this.timestamp, // New field
    required this.contact,
    required this.profileImg, 
    this.isAnonymous = false,// Updated field
    required this.username, // New field
  });

  factory RequestProductModel.fromMap(Map<String, dynamic> map) {
    String profileImg = map['profileImg'] ?? RandomUtil.generateRandomImage();
    return RequestProductModel(
      rpid: map['rpid'] as String, // New field
      userid: map['userid'] as String,
      productName: map['productName'] as String,
      price: map['price'] as double,
      description: map['description'] as String,
      timestamp: map['timestamp'] as String, // New field
      contact: map['contact'] as int,
      profileImg: profileImg, 
      isAnonymous: map['isAnonymous'] ?? false,// Updated field
      username: map['username'] != null ? map['username'] as String : "Anonymous" // New field
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
      'contact': contact,
      'profileImg': profileImg,
      'isAnonymous': isAnonymous, // Updated field
      'username': username, // New field
    };
  }
}
