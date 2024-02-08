import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        emit(AuthStateLoggedIn());
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

    on<AuthEventGoToRegistration>((event, emit) {
      emit(AuthStateIsInRegistrationView());
    });

    on<Register>((event, emit) async {
      //print("hai1");
      emit(AuthStateIsLoading());
      final email = event.email;
      final password = event.password;
      final phone = event.phone;
      final username = event.username;
      final rollnumber = event.rollnumber;
      final fullName = event.fullName;
      //print("hai2");
      int success = await event.authRepository.signUp(
          email: email,
          password: password,
          username: username,
          rollNumber: rollnumber,
          phoneNumber: phone,
          fullName: fullName);

      if (success == 1) {
        emit(AuthStateLoggedIn());
      } else {
        emit(AuthStateIsInRegistrationView());
      }
      // try {
      //   await event.authRepository.signUp(email: email, password: password);
      //   emit(AuthStateLoggedIn());
      // } on FirebaseAuthException catch (e) {
      //   print("~~~~~~~~~~" + e.toString());
      //   emit(AuthStateIsInRegistrationView());
      // }catch(e){
      //   print("~~~~~~~~~~" + e.toString());
      //   emit(AuthStateIsInRegistrationView());
      // }
    });

    on<AuthEventInitialize>((event, emit) async {
      print("inside bloc");
      int status = await event.authRepository.alreadyLoggedIn();
      print(status);
      if (status == 1) {
        emit(AuthStateLoggedOut());
      } else {
        emit(AuthStateLoggedIn());
      }
    });

    on<LogOut>((event, emit) async {
      emit(AuthStateIsLoading());
      await event.authRepository.logOut();
      emit(AuthStateLoggedOut());
    });
  }
}
