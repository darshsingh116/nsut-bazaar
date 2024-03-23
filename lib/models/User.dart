// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';

import 'package:nsutbazaar/utils/random.dart';

class UserModel {
  String uid;
  String fullname;
  String username;
  String email;
  int phoneNumber;
  String rollNumber;
  String profileImg;

  UserModel({
    required this.uid,
    required this.fullname,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.rollNumber,
    required this.profileImg, // Added profileImg property
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    String profileImg = map['profileImg'] ?? RandomUtil.generateRandomImage(); // Assign random image if null
    return UserModel(
      uid: map['uid'] as String,
      fullname: map['fullname'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as int,
      rollNumber: map['rollNumber'] as String,
      profileImg: profileImg,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullname': fullname,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'rollNumber': rollNumber,
      'profileImg': profileImg, // Include profileImg in JSON
    };
  }

}
