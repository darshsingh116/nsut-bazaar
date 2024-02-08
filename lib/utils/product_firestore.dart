import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nsutbazaar/models/ProductModel.dart';

class ProductFirestore {
  final FirebaseFirestore _firestore;

  ProductFirestore(this._firestore);

  Future<void> addSellProduct(ProductModel product) async {
    try {
      await _firestore.collection('sellProducts').add(product.toJson());
    } catch (e) {
      print('Error adding product: $e');
      // Handle the error as needed
    }
  }

  Future<List<ProductModel>> getAllSellProducts() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('sellProducts').get();

      // Convert each document in the query snapshot to a ProductModel object
      List<ProductModel> products = querySnapshot.docs.map((doc) {
        // Explicitly cast doc.data() to Map<String, dynamic>
        return ProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return products;
    } catch (e) {
      print('Error getting products: $e');
      // Handle the error as needed
      return []; // Return an empty list in case of error
    }
  }

  Future<List<ProductModel>> getAllSellProductsByUserId(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('sellProducts')
          .where('userid', isEqualTo: userId)
          .get();

      // Convert each document in the query snapshot to a ProductModel object
      List<ProductModel> products = querySnapshot.docs.map((doc) {
        // Explicitly cast doc.data() to Map<String, dynamic>
        return ProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return products;
    } catch (e) {
      print('Error getting products by user ID: $e');
      // Handle the error as needed
      return []; // Return an empty list in case of error
    }
  }

  Future<void> addRequestProduct(ProductModel product) async {
    try {
      await _firestore.collection('requestProduct').add(product.toJson());
    } catch (e) {
      print('Error adding request product: $e');
      // Handle the error as needed
    }
  }

  Future<List<ProductModel>> getAllRequestProducts() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('requestProduct').get();

      // Convert each document in the query snapshot to a ProductModel object
      List<ProductModel> products = querySnapshot.docs.map((doc) {
        // Explicitly cast doc.data() to Map<String, dynamic>
        return ProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return products;
    } catch (e) {
      print('Error getting request products: $e');
      // Handle the error as needed
      return []; // Return an empty list in case of error
    }
  }

  Future<List<ProductModel>> getAllRequestProductsByUserId(
      String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('requestProduct')
          .where('userid', isEqualTo: userId)
          .get();

      // Convert each document in the query snapshot to a ProductModel object
      List<ProductModel> products = querySnapshot.docs.map((doc) {
        // Explicitly cast doc.data() to Map<String, dynamic>
        return ProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return products;
    } catch (e) {
      print('Error getting request products by user ID: $e');
      // Handle the error as needed
      return []; // Return an empty list in case of error
    }
  }
}
