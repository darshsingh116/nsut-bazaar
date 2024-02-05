// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseStorageState {
  const FirebaseStorageState();
}

class FirebaseStorageInitialState extends FirebaseStorageState {}

class FirebaseStorageDataLoadedState extends FirebaseStorageState {
  ListResult filesNameList;
  List<String> previewsUrlList;
  FirebaseStorageDataLoadedState({
    required this.filesNameList,
    required this.previewsUrlList,
  });
}

class FirebaseStorageLoadingState extends FirebaseStorageState {}

class FirebaseStoreageErrorState extends FirebaseStorageState {}

//class FirebaseStorageDownloadedState extends FirebaseStorageState {}

class FirebaseStorageGoToDocViewState extends FirebaseStorageState {
  var filePath;
  FirebaseStorageGoToDocViewState({
    required this.filePath,
  });
}
