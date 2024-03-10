import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nsutbazaar/auth/bloc/auth_bloc.dart';
import 'package:nsutbazaar/auth/bloc/auth_event.dart';
import 'package:nsutbazaar/auth/bloc/auth_state.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/auth/login.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/BottomNavBar.dart';
import 'package:nsutbazaar/widgets/core/backgroundContainer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rollnumberController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<FirebaseRepository>();

    return backgroundContainer(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthStateLoggedOut) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                } else if (state is AuthStateLoggedIn) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => NavBarScreens()));
                }
              },
              builder: (context, state) {
                if (state is AuthStateIsInRegistrationView ||
                    state is AuthStateIsLoading) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Text(
                              "NSUT Bazaar",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Text(
                              "Create an Account",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28.sp,
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/signup.svg',
                            semanticsLabel: 'An SVG image',
                            width: 320.w,
                            height: 140.h,
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            height: 50.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 5.h),
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
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: TextField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 176, 153, 189),
                                        fontSize: 16.sp,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            height: 50.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 5.h),
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
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                      hintText: 'Username',
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 176, 153, 189),
                                        fontSize: 16.sp,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            height: 50.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 5.h),
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
                                    controller: rollnumberController,
                                    decoration: InputDecoration(
                                      hintText: 'Roll Number',
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 176, 153, 189),
                                        fontSize: 16.sp,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            height: 50.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 5.h),
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
                                    controller: phonenumberController,
                                    decoration: InputDecoration(
                                      hintText: 'Phone Number',
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 176, 153, 189),
                                        fontSize: 16.sp,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            height: 50.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 5.h),
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
                                    controller: fullnameController,
                                    decoration: InputDecoration(
                                      hintText: 'Full Name',
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 176, 153, 189),
                                        fontSize: 16.sp,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            height: 50.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 5.h),
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
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: TextField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 176, 153, 189),
                                        fontSize: 16.sp,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthStateIsLoading) {
                                return CircularProgressIndicator(
                                  color: Colors.white,
                                );
                              }
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: SizedBox(
                                  height: 45.h,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      final email = emailController.text;
                                      final password = passwordController.text;
                                      final rollnumber =
                                          rollnumberController.text;
                                      final username = usernameController.text;
                                      final phonenumber =
                                          phonenumberController.text;
                                      final fullname = fullnameController.text;
                                      if (email != "" &&
                                          password != "" &&
                                          rollnumber != "" &&
                                          username != "") {
                                        context.read<AuthBloc>().add(Register(
                                              email: email,
                                              password: password,
                                              rollnumber: rollnumber,
                                              username: username,
                                              phone: int.parse(phonenumber),
                                              fullName: fullname,
                                              authRepository: authRepository,
                                            ));
                                      }
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
                                      "Register",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.w),
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<AuthBloc>()
                                    .add(AuthEventGoToLogin());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account? ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  Text(
                                    "Log in",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    rollnumberController.dispose();
    phonenumberController.dispose();
    fullnameController.dispose();
    super.dispose();
  }
}
