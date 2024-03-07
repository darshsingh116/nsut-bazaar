import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/repositories/local_data.dart';

abstract class ListingsEvent {
  final FirebaseRepository firebaseRepository;
  ListingsEvent({required this.firebaseRepository});
}

class ListingsEventGetAllList extends ListingsEvent {
  final LocalData localData;
  ListingsEventGetAllList({required this.localData,required super.firebaseRepository});
}

class ListingsEventInitialize extends ListingsEvent {
  ListingsEventInitialize({required super.firebaseRepository});
}

class ListingsEventGetSearchedList extends ListingsEvent {
  final String searchParameter;

  ListingsEventGetSearchedList(
      {required this.searchParameter, required super.firebaseRepository});
}

class ListingsEventGetCategorySearchedList extends ListingsEvent {
  final String category;

  ListingsEventGetCategorySearchedList(
      {required this.category, required super.firebaseRepository});
}
