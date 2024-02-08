import 'package:nsutbazaar/repositories/firebase_repo.dart';

abstract class ListingsEvent {
  final FirebaseRepository firebaseRepository;
  ListingsEvent({required this.firebaseRepository});
}

class ListingsEventGetAllList extends ListingsEvent {
  ListingsEventGetAllList({required super.firebaseRepository});
}

class ListingsEventGetSearchedList extends ListingsEvent {
  final String searchParameter;

  ListingsEventGetSearchedList({required this.searchParameter, required super.firebaseRepository});
}
