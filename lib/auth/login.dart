import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nsutbazaar/auth/bloc/auth_bloc.dart';
import 'package:nsutbazaar/auth/bloc/auth_event.dart';
import 'package:nsutbazaar/auth/bloc/auth_state.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/BottomNavBar.dart';
import 'package:nsutbazaar/auth/register.dart';
import 'package:nsutbazaar/widgets/backgroundContainer.dart';


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
    //context.read<AuthBloc>().emit(AuthStateLoggedOut());

    

    return Container(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthStateIsInRegistrationView) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => RegisterScreen()));
          } else if (state is AuthStateLoggedIn) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => NavBarScreens()));
          }
        },
        builder: (context, state) {
          if (state is AuthStateInitial) {
            print("initializing....");
            context
                .read<AuthBloc>()
                .add(AuthEventInitialize(authRepository: authRepository));
            return Container();
          } else if (state is AuthStateLoggedOut ||
              state is AuthStateIsLoading) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Color.fromARGB(255, 35, 38, 45),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
                    child: Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                child: SizedBox(
                                  height: 60,
                                  child: Text(
                                    "Welcome Back!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 45,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(30, 80, 30, 5),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.all(10.0),
                                    //   child: Text(
                                    //     "Email",
                                    //     style: TextStyle(
                                    //       color: Colors.white,
                                    //       fontSize: 15,
                                    //       fontWeight: FontWeight.bold,
                                    //     ),
                                    //   ),
                                    // ),
                                    TextField(
                                      controller: emailController,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Colors.white,
                                        ),
                                        fillColor: Colors.black,
                                        filled: true,
                                        hintText: 'Email',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.all(10.0),
                                    //   child: Text(
                                    //     "Password",
                                    //     style: TextStyle(
                                    //       color: Colors.white,
                                    //       fontSize: 15,
                                    //       fontWeight: FontWeight.bold,
                                    //     ),
                                    //   ),
                                    // ),
                                    TextField(
                                      controller: passwordController,
                                      obscureText: true,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.white,
                                        ),
                                        fillColor: Colors.black,
                                        filled: true,
                                        hintText: 'Password',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                if (state is AuthStateIsLoading) {
                                  return CircularProgressIndicator(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  );
                                }
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      final email = emailController.text;
                                      final password = passwordController.text;
                                      context.read<AuthBloc>().add(LogIn(
                                            email: email,
                                            password: password,
                                            authRepository: authRepository,
                                          ));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.13,
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                          ],
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(AuthEventGoToRegistration());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Dont have an account?  ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        )),
                                    Text("Create Account",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
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
  


// final email = emailController.text;
// final password = passwordController.text;
// authBloc.add(LogIn(email: email, password: password));