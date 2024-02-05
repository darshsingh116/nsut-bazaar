abstract class AuthState {}

class AuthStateInitial extends AuthState{}

class AuthStateLoggedIn extends AuthState {
  //final User user;
  AuthStateLoggedIn(); //{required this.user};
}

class AuthStateLoggedOut extends AuthState {}

class AuthStateIsInRegistrationView extends AuthState {}

class AuthStateIsLoading extends AuthState{}
