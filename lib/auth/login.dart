import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsutbazaar/auth/bloc/auth_bloc.dart';
import 'package:nsutbazaar/auth/bloc/auth_event.dart';
import 'package:nsutbazaar/auth/bloc/auth_state.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/BottomNavBar.dart';
import 'package:nsutbazaar/auth/register.dart';
import 'package:nsutbazaar/widgets/core/backgroundContainer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                if (state is AuthStateIsInRegistrationView) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                } else if (state is AuthStateLoggedIn) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NavBarScreens()),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthStateInitial) {
                  context.read<AuthBloc>().add(
                        AuthEventInitialize(authRepository: authRepository),
                      );
                  return Container();
                } else if (state is AuthStateLoggedOut ||
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
                              "Welcome Back",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28.sp,
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/login.svg',
                            semanticsLabel: 'An SVG image',
                            width: 300.w,
                            height: 210.h,
                          ),
                          SizedBox(height: 30.h),
                          Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 36, 28, 41),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: Color.fromARGB(255, 74, 56, 87),
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                ),
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
                                          EdgeInsets.symmetric(horizontal: 0.0),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 36, 28, 41),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: Color.fromARGB(255, 74, 56, 87),
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                ),
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
                                          EdgeInsets.symmetric(horizontal: 0.0),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          if (state is AuthStateIsLoading)
                            CircularProgressIndicator(
                              color: Colors.white,
                            )
                          else
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0.w),
                              child: SizedBox(
                                height: 45.h,
                                width: double.infinity,
                                child: ElevatedButton(
                                  child: Text(
                                    'Log In',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    final email = emailController.text;
                                    final password = passwordController.text;
                                    context.read<AuthBloc>().add(
                                          LogIn(
                                            email: email,
                                            password: password,
                                            authRepository: authRepository,
                                          ),
                                        );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: PurpleTheme
                                        .ButtonLightPurpleColor, // Light purple
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(height: 40.h),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<AuthBloc>()
                                  .add(AuthEventGoToRegistration());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                Text(
                                  "Create Account",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
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
    passwordController.dispose();
    super.dispose();
  }
}
