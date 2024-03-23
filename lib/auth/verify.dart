import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsutbazaar/auth/bloc/auth_bloc.dart';
import 'package:nsutbazaar/auth/bloc/auth_event.dart';
import 'package:nsutbazaar/auth/bloc/auth_state.dart';
import 'package:nsutbazaar/constants/darkTheme.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/BottomNavBar.dart';
import 'package:nsutbazaar/auth/register.dart';
import 'package:nsutbazaar/widgets/core/backgroundContainer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
  }
  
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
                if (state is AuthStateCheckVerified || state is AuthStateIsLoading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200.h,
                        ),
                        Text(
                          "Verification Email sent",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          authRepository.userModel.email,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            decoration: TextDecoration.underline
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.w),
                          child: SizedBox(
                            height: 40.h,
                            width: 300.w,
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                    Verify(authRepository: authRepository));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: PurpleTheme
                                    .ButtonLightPurpleColor, // Light purple
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) {
                                  if(state is AuthStateIsLoading){
                                    CircularProgressIndicator();
                                  }return Text(
                                    'Confirm',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     GestureDetector(
                        //       onTap: () {
                        //         authRepository.firebaseAuth.currentUser?.sendEmailVerification();
                        //       },
                        //       child: Text(
                        //                 "Send email",
                        //                 style: TextStyle(
                        //                   color: DarkTheme.dtLightPurple,
                        //                   fontSize: 15.sp,
                        //                   decoration: TextDecoration.underline,
                        //                 ),
                        //               ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
