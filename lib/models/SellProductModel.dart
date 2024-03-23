import 'package:nsutbazaar/utils/random.dart';

class SellProductModel {
  String spid; // sell pid
  String userid;
  String productName;
  double price;
  String description;
  String imageUrl;
  int contactNumber; // New field
  bool isBooks;
  bool isSports;
  bool isAcademicTool;
  bool isOthers;
  String timestamp; // New field
  String profileImg; // New field
  bool isAnonymous; // New field
  String username; // New field

  SellProductModel({
    required this.spid, // New field
    required this.userid,
    required this.productName,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.contactNumber,
    required this.isBooks,
    required this.isSports,
    required this.isAcademicTool,
    required this.isOthers,
    required this.timestamp, // New field
    required this.profileImg, // New field
    this.isAnonymous = false, // Default value
    required this.username, // New field
  });

  factory SellProductModel.fromMap(Map<String, dynamic> map) {
    String profileImg = map['profileImg'] ?? RandomUtil.generateRandomImage();
    return SellProductModel(
      spid: map['spid'] as String, // New field
      userid: map['userid'] as String,
      productName: map['productName'] as String,
      price: map['price'] as double,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      contactNumber: map['contactNumber'] as int, // New field
      isBooks: map['isBooks'] != null ? map['isBooks'] as bool : false,
      isSports: map['isSports'] != null ? map['isSports'] as bool : false,
      isAcademicTool: map['isAcademicTool'] != null ? map['isAcademicTool'] as bool : false,
      isOthers: map['isOthers'] != null ? map['isOthers'] as bool : false,
      timestamp: map['timestamp'] as String, // New field
      profileImg: profileImg, // New field
      isAnonymous: map['isAnonymous'] ?? false, // New field with default value
      username: map['username'] != null ? map['username'] as String : "Anonymous", // New field
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
      'isBooks': isBooks,
      'isSports': isSports,
      'isAcademicTool': isAcademicTool,
      'isOthers': isOthers,
      'timestamp': timestamp, // New field
      'profileImg': profileImg, // New field
      'isAnonymous': isAnonymous, // New field
      'username': username, // New field
    };
  }
}
