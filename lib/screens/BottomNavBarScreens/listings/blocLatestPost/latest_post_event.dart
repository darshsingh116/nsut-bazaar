import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/repositories/local_data.dart';

abstract class LatestPostEvent {
  final FirebaseRepository firebaseRepository;
  LatestPostEvent({required this.firebaseRepository});
}

class LatestPostEventGetAllList extends LatestPostEvent {
  LatestPostEventGetAllList({required super.firebaseRepository});
}

class LatestPostEventInitialize extends LatestPostEvent {
  LatestPostEventInitialize({required super.firebaseRepository});
}

