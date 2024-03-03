import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nsutbazaar/models/SellProductModel.dart';
import 'package:nsutbazaar/models/RequestProductModel.dart';

class ProductFirestore {
  final FirebaseFirestore _firestore;

  ProductFirestore(this._firestore);

  Future<void> addSellProduct(SellProductModel product) async {
    try {
      await _firestore.collection('sellProducts').add(product.toJson());
    } catch (e) {
      print('Error adding product: $e');
      // Handle the error as needed
    }
  }

  Future<List<SellProductModel>> getAllSellProducts() async {
    print("getsellprod");
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('sellProducts').get();

      // Convert each document in the query snapshot to a SellProductModel object
      List<SellProductModel> products = querySnapshot.docs.map((doc) {
        // Explicitly cast doc.data() to Map<String, dynamic>
        return SellProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return products;
    } catch (e) {
      print('Error getting products: $e');
      // Handle the error as needed
      return []; // Return an empty list in case of error
    }
  }

  Future<List<SellProductModel>> getAllSellProductsByUserId(
      String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('sellProducts')
          .where('userid', isEqualTo: userId)
          .get();

      // Convert each document in the query snapshot to a SellProductModel object
      List<SellProductModel> products = querySnapshot.docs.map((doc) {
        // Explicitly cast doc.data() to Map<String, dynamic>
        return SellProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return products;
    } catch (e) {
      print('Error getting products by user ID: $e');
      // Handle the error as needed
      return []; // Return an empty list in case of error
    }
  }

  Future<void> addRequestProduct(RequestProductModel product) async {
    try {
      await _firestore.collection('requestProduct').add(product.toJson());
    } catch (e) {
      print('Error adding request product: $e');
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
      print('Error getting request products: $e');
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
          .get();

      // Convert each document in the query snapshot to a RequestProductModel object
      List<RequestProductModel> products = querySnapshot.docs.map((doc) {
        // Explicitly cast doc.data() to Map<String, dynamic>
        return RequestProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return products;
    } catch (e) {
      print('Error getting request products by user ID: $e');
      // Handle the error as needed
      return []; // Return an empty list in case of error
    }
  }

  Future<void> deleteSellProduct(String spid) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('sellProducts')
          .where('spid', isEqualTo: spid)
          .get();

      querySnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
        print('Product with SPID: $spid deleted successfully');
      });
    } catch (e) {
      print('Error deleting product: $e');
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
        print('Product with RPID: $rpid deleted successfully');
      });
    } catch (e) {
      print('Error deleting product: $e');
      // Handle the error as needed
    }
  }
}
