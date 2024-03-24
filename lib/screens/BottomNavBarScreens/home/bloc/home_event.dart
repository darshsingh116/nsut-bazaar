 import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/utils/product_firestore.dart';

class HomeEvent {}

  class HomeEventGetData extends HomeEvent{
    final FirebaseRepository firebaseRepository;

  HomeEventGetData({required this.firebaseRepository});
  }
