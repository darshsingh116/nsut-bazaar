// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  String fullname;
  String username;
  String email; // Added email property
  int phoneNumber;
  String rollNumber;

  UserModel({
    required this.fullname,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.rollNumber,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullname: map['fullname'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as int,
      rollNumber: map['rollNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'rollNumber': rollNumber,
    };
  }
}
