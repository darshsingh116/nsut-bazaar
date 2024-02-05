import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseStoreageRepo {
  final _firebaseStorageInstance = FirebaseStorage.instance;

  Future<ListResult> getPdfList() {
    Future<ListResult> futureFilesNameList =
        _firebaseStorageInstance.ref('/resources').listAll();

    return futureFilesNameList;
  }

  

  Future<List<String>> getPreviewsurl(ListResult refList) async {
    int n = refList.items.length;
    List<String> previewsUrl = List.filled(10, "https://wallpapers.com/images/hd/crying-pictures-6gh0n5wvrywal8d6.jpg");
    var s = refList.items;
      
    try {
      
      var url; 
      for (int index = 0; index < n; index++) {
        url = await s[index].getDownloadURL();
        previewsUrl[index] = url;
      }

      return previewsUrl;
    } catch (e) {
      print(e.toString());
      return [""];
    }
  }


  
}
