import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsutbazaar/auth/bloc/auth_bloc.dart';
import 'package:nsutbazaar/auth/bloc/auth_event.dart';
import 'package:nsutbazaar/auth/bloc/auth_state.dart';
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width *
                        0.3, // Adjust the width as needed
                    height: MediaQuery.of(context).size.width *
                        0.3, // Adjust the height as needed
                    margin: EdgeInsets.all(2), // Add a margin for the gap
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color.fromARGB(255, 206, 255, 68),
                        width: 1, // Adjust the border width as needed
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/paimon.jpeg', // Replace with your image URL
                          fit: BoxFit.cover, // Adjust the fit as needed
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      authRepository.userModel.username,
                      style: TextStyle(
                          color: Color.fromARGB(255, 206, 255, 68),
                          fontSize: 32),
                    ),
                  ),
                ),
                Container(
                  //height: MediaQuery.of(context).size.height * 0.01,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "username",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width * 0.80,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: Text(
                      "uwu",
                      style: TextStyle(
                          color: Color.fromARGB(255, 164, 161, 161),
                          fontSize: 15),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width * 0.80,
                  color: Colors.black,
                ),
                SizedBox(height: 50),
                
                
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.055,
                    child: ElevatedButton(
                      onPressed: () {
                        
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(
                            color: Color.fromARGB(
                                255, 206, 255, 68), // Define the border color
                            width: 1.0, // Define the border width
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(
                              155, 41, 41, 41), // Define the background color
                        ),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: Color.fromARGB(255, 206, 255, 68),
                            fontSize:
                                MediaQuery.of(context).size.height * 0.019),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.055,
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthStateIsLoading) {
                          return CircularProgressIndicator(
                            color: const Color.fromARGB(255, 255, 255, 255),
                          );
                        }
                        return ElevatedButton(
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(LogOut(authRepository));
                          },
                          style: ButtonStyle(
                            side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(
                                color: Color.fromARGB(255, 206, 255,
                                    68), // Define the border color
                                width: 1.0, // Define the border width
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(155, 41, 41,
                                  41), // Define the background color
                            ),
                          ),
                          child: Text('Log Out',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 206, 255, 68),
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.019)),
                        );
                      },
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
