import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nsutbazaar/extensions/datetime.dart';
import 'package:nsutbazaar/models/SellProductModel.dart';
import 'package:nsutbazaar/models/RequestProductModel.dart';
import 'package:nsutbazaar/repositories/firebase_storage_repo.dart';

class ProductFirestore {
  final FirebaseFirestore _firestore;

  ProductFirestore(this._firestore);

  Future<void> addSellProduct(SellProductModel product) async {
    try {
      await _firestore.collection('sellProducts').add(product.toJson());
    } catch (e) {
      // Handle the error as needed
    }
  }

  Future<List<SellProductModel>> getAllSellProducts() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('sellProducts')
          .orderBy('timestamp',
              descending: true) // Sort by timestamp in descending order
          .get();

      List<SellProductModel> products = querySnapshot.docs.map((doc) {
        return SellProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return products;
    } catch (e) {
      return [];
    }
  }


Future<Map<String, dynamic>> getCountsAndData() async {
  CollectionReference sellProductsRef = _firestore.collection('sellProducts');
  CollectionReference requestProductRef = _firestore.collection('requestProduct');

  // Get the count of documents in each collection
  int sellProductsCount = (await sellProductsRef.get()).size;
  int requestProductCount = (await requestProductRef.get()).size;
int currentTime = DateTime.now().millisecondsSinceEpoch;
  // Get data from sellProducts collection with timestamp for today

  // Get data from sellProducts collection with timestamp for today
  QuerySnapshot<Object?> todaySellProductsSnapshot = await sellProductsRef.get();
  int todaySellProductsCount = 0;

  todaySellProductsSnapshot.docs.forEach((doc) {
    String timestampString = doc['timestamp']; // Assuming 'timestamp' is the field name in Firestore
    int timestamp = int.tryParse(timestampString) ?? 0; // Convert string to int, default to 0 if parsing fails
    if (timestamp >= currentTime - const Duration(days: 1).inMilliseconds) {
      todaySellProductsCount++;
    }
  });

    QuerySnapshot<Object?> todayRequestProductsSnapshot = await requestProductRef.get();
  int todayRequestProductsCount = 0;

  todayRequestProductsSnapshot.docs.forEach((doc) {
    String timestampString = doc['timestamp']; // Assuming 'timestamp' is the field name in Firestore
    int timestamp = int.tryParse(timestampString) ?? 0; // Convert string to int, default to 0 if parsing fails
    if (timestamp >= currentTime - const Duration(days: 1).inMilliseconds) {
      todayRequestProductsCount++;
    }
  });

  return {
    'sellProductsCount': sellProductsCount,
    'requestProductCount': requestProductCount,
    'todaySellProductsCount': (todaySellProductsCount+todayRequestProductsCount),
  };
}




  Future<List<SellProductModel>> getAllSellProductsByUserId(
      String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('sellProducts')
          .where('userid', isEqualTo: userId)
          .orderBy('timestamp',
              descending: true) // Sort by timestamp in descending order
          .get();

      List<SellProductModel> products = querySnapshot.docs.map((doc) {
        return SellProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return products;
    } catch (e) {
      return [];
    }
  }

  Future<void> addRequestProduct(RequestProductModel product) async {
    try {
      await _firestore.collection('requestProduct').add(product.toJson());
    } catch (e) {
      // Handle the error as needed
    }
  }

  Future<List<RequestProductModel>> getAllRequestProducts() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('requestProduct').get();

      // Convert each document in the query snapshot to a RequestProductModel object
      List<RequestProductModel> products = querySnapshot.docs.map((doc) {
        // Explicitly cast doc.data() to Map<String, dynamic>
        return RequestProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return products;
    } catch (e) {
      // Handle the error as needed
      return []; // Return an empty list in case of error
    }
  }

  Future<List<RequestProductModel>> getAllRequestProductsByUserId(
      String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('requestProduct')
          .where('userid', isEqualTo: userId)
          .orderBy('timestamp',
              descending: true) // Sort by timestamp in descending order
          .get();

      List<RequestProductModel> products = querySnapshot.docs.map((doc) {
        return RequestProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return products;
    } catch (e) {
      return [];
    }
  }

  Future<void> deleteSellProduct(SellProductModel sellProductModel,
      FirebaseStorageRepo firebaseStorageRepo, ) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('sellProducts')
          .where('spid', isEqualTo: sellProductModel.spid)
          .get();

      querySnapshot.docs.forEach((doc) async {
        // Get the image URL from the document data
        //String imageURL = doc.data()[sellProductModel.imageUrl];

        // Delete the image from Firebase Storage

        // Delete the document from Firestore
        await doc.reference.delete();
        await firebaseStorageRepo.deleteImageFile(sellProductModel.imageUrl);

      });
    } catch (e) {
      // Handle the error as needed
    }
  }

  Future<void> deleteRequestProduct(String rpid) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('requestProduct')
          .where('rpid', isEqualTo: rpid)
          .get();

      querySnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
      });
    } catch (e) {
      // Handle the error as needed
    }
  }

}
