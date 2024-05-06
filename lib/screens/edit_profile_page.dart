import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nsutbazaar/constants/darkTheme.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/repositories/firebase_storage_repo.dart';
import 'package:nsutbazaar/utils/user_control.dart';
import 'package:nsutbazaar/widgets/core/backgroundContainer.dart';
import 'package:nsutbazaar/widgets/image_dialog.dart';

class EditProfilePage extends StatefulWidget {
  final Function() onUpdateProfile;
 
  

  const EditProfilePage({Key? key, required this.onUpdateProfile})
      : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _rollNumberController = TextEditingController();
  String progileImg = "";

  @override
  Widget build(BuildContext context) {
    FirebaseStorageRepo _firebaseStorageRepo =
        context.read<FirebaseStorageRepo>();
    FirebaseRepository _authRepository = context.read<FirebaseRepository>();
    UserControl userControl =
        UserControl(_firebaseStorageRepo, _authRepository);
    progileImg = (progileImg=="")?_authRepository.userModel.profileImg:progileImg;

    return backgroundContainer(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
  context: context,
  builder: (BuildContext context) {
    return ImageDialog(assetImage: AssetImage(
                            'assets/${progileImg}'));
  },
);
                      },
                      child: CircleAvatar(
                        radius: 80.r,
                        backgroundImage: AssetImage(
                            'assets/${progileImg}'), // Replace 'assets/avatar_image.png' with your image asset path
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10.w,
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: DarkTheme.dtLightPurple,
                        child: IconButton(
                          icon: Icon(Icons.shuffle, size: 15.sp),
                          color: Colors.black,
                          onPressed: () {
                            int currentNumber =
                                int.parse(progileImg.split('.')[0]);
                            int nextNumber = currentNumber + 1;
                            if (nextNumber > 3) {
                              nextNumber = 1; // Loop back to the first image
                            }
                            setState(() {
                              progileImg = '$nextNumber.jpeg';
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Container(
                  height: 40.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 36, 28, 41),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Color.fromARGB(255, 74, 56, 87),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextField(
                          controller: _fullnameController,
                          decoration: InputDecoration(
                            hintText: 'Full Name',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 176, 153, 189),
                              fontSize: 16.sp,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 6.h),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  height: 40.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 36, 28, 41),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Color.fromARGB(255, 74, 56, 87),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 176, 153, 189),
                              fontSize: 16.sp,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 6.h),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  height: 40.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 36, 28, 41),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Color.fromARGB(255, 74, 56, 87),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[0-9]"))
                          ],
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 176, 153, 189),
                              fontSize: 16.sp,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 6.h),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  height: 40.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 36, 28, 41),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Color.fromARGB(255, 74, 56, 87),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.description,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextField(
                          controller: _rollNumberController,
                          decoration: InputDecoration(
                            hintText: 'Roll Number',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 176, 153, 189),
                              fontSize: 16.sp,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 6.h),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                SizedBox(
                  height: 45.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle updating profile here
                      String newFullname = _fullnameController.text;
                      String newUsername = _usernameController.text;
                      int newPhoneNumber =
                          int.tryParse(_phoneNumberController.text) ?? 0;
                      String newRollNumber = _rollNumberController.text;

                      // Update user's profile with newFullname, newUsername, newEmail, newPhoneNumber, and newRollNumber
                      userControl.editUserInfo(newFullname, newUsername,
                          newPhoneNumber, newRollNumber, progileImg);
                      widget
                          .onUpdateProfile(); // Pass updated data back to the profile page
                      Navigator.pop(context); // Go back to the profile page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          PurpleTheme.ButtonLightPurpleColor, // Light purple
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _usernameController.dispose();
    _phoneNumberController.dispose();
    _rollNumberController.dispose();
    super.dispose();
  }
}
