// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  
  SplashScreen({
    Key? key,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          FirebaseAuth.instance.currentUser!.email.toString(),
        ),
      ),
    );
  }
}
