import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nsutbazaar/models/User.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseStorageRepo {
  final _firebaseStorageInstance = FirebaseStorage.instance;

  Future<String?> uploadImageFile(File imageFile, UserModel userModel) async {
    try {
      final uid = userModel.uid;
      final fileName = imageFile.path.split('/').last;
      final path = '$uid/$fileName';
      final Reference storageRef =
          _firebaseStorageInstance.ref('/products').child(path);

      // Upload the file to Firebase Storage
      await storageRef.putFile(imageFile);

      // Get the download URL for the uploaded file
      final String downloadURL = await storageRef.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  // Function to delete an image file
  Future<void> deleteImageFile(String downloadURL) async {
    print("in img delete func");
    try {
      Reference imageRef = _firebaseStorageInstance.refFromURL(downloadURL);
      print(imageRef);

      // Delete the image file
      await imageRef.delete();
      print('Image deleted successfully');
    } catch (e) {
      print('Error deleting image: $e');
    }
  }
}
