import 'package:nsutbazaar/repositories/firebase_repo.dart';

abstract class RequestsEvent {
  final FirebaseRepository firebaseRepository;
  RequestsEvent({required this.firebaseRepository});
}

class RequestsEventGetAllList extends RequestsEvent {
  RequestsEventGetAllList({required super.firebaseRepository});
}

class RequestsEventInitialize extends RequestsEvent {
  RequestsEventInitialize({required super.firebaseRepository});
}

class RequestsEventGetSearchedList extends RequestsEvent {
  final String searchParameter;

  RequestsEventGetSearchedList({required this.searchParameter, required super.firebaseRepository});
}
