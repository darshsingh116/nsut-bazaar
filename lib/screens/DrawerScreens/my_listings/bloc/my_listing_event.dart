import 'package:nsutbazaar/repositories/firebase_repo.dart';

abstract class ListingEvent {
  const ListingEvent();
}

class ListingEventInitialize implements ListingEvent {}

class ListingEventGetData implements ListingEvent {
  final FirebaseRepository firebaseRepository;

  ListingEventGetData({required this.firebaseRepository});
}
