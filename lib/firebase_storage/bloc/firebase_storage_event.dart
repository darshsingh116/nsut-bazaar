// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_storage/firebase_storage.dart';

import 'package:nsutbazaar/repositories/firebase_storage_repo.dart';

abstract class FirebaseStorageEvent {
  FirebaseStorageRepo firebaseStorageRepo;
  FirebaseStorageEvent({
    required this.firebaseStorageRepo,
  });
}

//class FirebaseStorageInitalEvent extends FirebaseStorageEvent{}

class FirebaseStorageGetFilesListEvent extends FirebaseStorageEvent {
  FirebaseStorageGetFilesListEvent({required super.firebaseStorageRepo});
}

class FirebaseStorageDownloadFilesEvent extends FirebaseStorageEvent {
  Reference ref;

  FirebaseStorageDownloadFilesEvent({
    required this.ref,
    required super.firebaseStorageRepo,
  });
}
