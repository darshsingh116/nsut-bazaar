import 'dart:io' as io;
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nsutbazaar/firebase_storage/bloc/firebase_storage_event.dart';
import 'package:nsutbazaar/firebase_storage/bloc/firebase_storage_state.dart';
import 'package:nsutbazaar/repositories/firebase_storage_repo.dart';
class FirebaseStorageBloc
    extends Bloc<FirebaseStorageEvent, FirebaseStorageState> {
  FirebaseStorageBloc() : super(FirebaseStorageInitialState()) {
    //Events handlers here

    on<FirebaseStorageGetFilesListEvent>((event, emit) async {
      
    });

    
  }
}

Future<ListResult> firebaseGetFiles(
    FirebaseStoreageRepo firebaseStoreageRepo) async {
  Future<ListResult> futureFiles = firebaseStoreageRepo.getPdfList();
  return futureFiles;
}

