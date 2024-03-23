import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nsutbazaar/auth/bloc/auth_event.dart';
import 'package:nsutbazaar/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateInitial()) {
    on<LogIn>((event, emit) async {
      emit(AuthStateIsLoading());
      final email = event.email;
      final password = event.password;
      int success =
          await event.authRepository.login(email: email, password: password);
      if (success == 1) {
      User user = event.authRepository.firebaseAuth.currentUser!;
      user.reload();
      bool isVerified = user.emailVerified;
      emit(AuthStateIsLoading());
      print("check verify");
      print(isVerified);
      if(isVerified == true){
        emit(AuthStateLoggedIn());
      }else{
        emit(AuthStateCheckVerified());
      }
        
      } else {
        emit(AuthStateLoggedOut());
      }
      // try {
      //   final userCredentail = await FirebaseAuth.instance
      //       .signInWithEmailAndPassword(email: email, password: password);
      //   emit(AuthStateLoggedIn());
      // } on FirebaseAuthException catch (e) {
      //   emit(AuthStateLoggedOut());
      // }
    });

    on<AuthEventGoToLogin>((event, emit) async {
      emit(AuthStateLoggedOut());
    });

     on<Verify>((event, emit) async {
      User user = event.authRepository.firebaseAuth.currentUser!;
      user.reload();
      bool isVerified = user.emailVerified;
      emit(AuthStateIsLoading());
      print("check verify");
      print(isVerified);
      if(isVerified == true){
        emit(AuthStateLoggedIn());
      }
    });

    on<AuthEventGoToRegistration>((event, emit) {
      emit(AuthStateIsInRegistrationView());
    });

 on<Register>((event, emit) async {
  emit(AuthStateIsLoading());
  
  final email = event.email;
  final password = event.password;
  final phone = event.phone;
  final username = event.username;
  final rollnumber = event.rollnumber;
  final fullName = event.fullName;
  
  // Check if the email is from @nsut.ac.in domain
  if (email.endsWith('@nsut.ac.in')) {
    int success = await event.authRepository.signUp(
      email: email,
      password: password,
      username: username,
      rollNumber: rollnumber,
      phoneNumber: phone,
      fullName: fullName,
    );

    if (success == 1) {
      emit(AuthStateCheckVerified());
    } else {
      emit(AuthStateIsInRegistrationView());
    }
  } else {
    // Show a snackbar indicating that only @nsut.ac.in emails are allowed
    ScaffoldMessenger.of(event.context).showSnackBar(
      SnackBar(
        content: Text('Only @nsut.ac.in emails are allowed for registration.'),
        duration: Duration(seconds: 3),
      ),
    );

    emit(AuthStateIsInRegistrationView());
  }
});

    on<AuthEventInitialize>((event, emit) async {
      print("inside bloc");
      int status = await event.authRepository.alreadyLoggedIn();
      print(status);
      if (status == 1) {
        emit(AuthStateLoggedOut());
      } else {
         User user = event.authRepository.firebaseAuth.currentUser!;
      user.reload();
      bool isVerified = user.emailVerified;
      emit(AuthStateIsLoading());
      print("check verify");
      print(isVerified);
      if(isVerified == true){
        emit(AuthStateLoggedIn());
      }else{
        emit(AuthStateCheckVerified());
      }
      }
    });

    on<LogOut>((event, emit) async {
      emit(AuthStateIsLoading());
      await event.authRepository.logOut();
      emit(AuthStateLoggedOut());
    });
  }
}
