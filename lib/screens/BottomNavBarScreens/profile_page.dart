import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nsutbazaar/auth/bloc/auth_bloc.dart';
import 'package:nsutbazaar/auth/bloc/auth_event.dart';
import 'package:nsutbazaar/auth/bloc/auth_state.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/extensions/strings.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/auth/login.dart';
import 'dart:ui';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<FirebaseRepository>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoggedOut) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 320.h,
                  width: double.infinity,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 64.r,
                          backgroundImage: AssetImage(
                              'assets/paimon.jpeg'), // Replace with your local asset image path
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          authRepository.userModel.fullname.toTitleCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '@${authRepository.userModel.username}',
                          style: TextStyle(
                            color: PurpleTheme.LightPurpleColor,
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          authRepository.userModel.email,
                          style: TextStyle(
                            color: PurpleTheme.LightPurpleColor,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        SizedBox(
                            height: 40.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 173.w,
                                  height: 40.h,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Add your functionality for Edit Profile button here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          PurpleTheme.ButtonDarkPurpleColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                    ),
                                    child: Text(
                                      'Edit Profile',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.0), // Space between buttons
                                SizedBox(
                                  height: 40.h,
                                  width: 173.w,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Add your functionality for Log Out button here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: PurpleTheme
                                          .ButtonLightPurpleColor, // Light purple
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                    ),
                                    child: Text(
                                      'Log Out',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                  height: 56.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Phone Number :",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          authRepository.userModel.phoneNumber.toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 56.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Roll Number :",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          authRepository.userModel.rollNumber.toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        )
                      ],
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
}
