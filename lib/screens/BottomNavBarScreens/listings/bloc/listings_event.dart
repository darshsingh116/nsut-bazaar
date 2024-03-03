import 'package:nsutbazaar/repositories/firebase_repo.dart';

abstract class ListingsEvent {
  final FirebaseRepository firebaseRepository;
  ListingsEvent({required this.firebaseRepository});
}

class ListingsEventGetAllList extends ListingsEvent {
  ListingsEventGetAllList({required super.firebaseRepository});
}

class ListingsEventInitialize extends ListingsEvent {
  ListingsEventInitialize({required super.firebaseRepository});
}

class ListingsEventGetSearchedList extends ListingsEvent {
  final String searchParameter;

  ListingsEventGetSearchedList({required this.searchParameter, required super.firebaseRepository});
}
