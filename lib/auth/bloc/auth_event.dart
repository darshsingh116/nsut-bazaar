// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize implements AuthEvent {
  final FirebaseRepository authRepository;
  const AuthEventInitialize({required this.authRepository});
}

class LogIn implements AuthEvent {
  final BuildContext context;
  final FirebaseRepository authRepository;
  final String email;
  final String password;
  const LogIn(this.context,  
      {required this.email,
      required this.password,
      required this.authRepository});
}

class LogOut implements AuthEvent {
  final FirebaseRepository authRepository;
  const LogOut(
    this.authRepository,
  );
}

class Verify implements AuthEvent{
  final FirebaseRepository authRepository;

  Verify({required this.authRepository});
}

class Register implements AuthEvent {
  final BuildContext context;
  final FirebaseRepository authRepository;
  final String email;
  final String password;
  final String rollnumber;
  final String username;
  final int phone;
  final String fullName;
  const Register( 
      {required this.context,
        required this.authRepository,
      required this.email,
      required this.password,
      required this.rollnumber,
      required this.username,
      required this.phone,
      required this.fullName});
}

class AuthEventGoToRegistration implements AuthEvent {
  const AuthEventGoToRegistration();
}

class AuthEventGoToLogin implements AuthEvent {
  const AuthEventGoToLogin();
}
