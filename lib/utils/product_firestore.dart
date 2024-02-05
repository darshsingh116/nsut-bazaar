import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nsutbazaar/models/ProductModel.dart';

class ProductFirestore {
  final FirebaseFirestore _firestore;

  ProductFirestore(this._firestore);

  Future<void> addProduct(ProductModel product) async {
    try {
      await _firestore.collection('sellProducts').add(product.toJson());
    } catch (e) {
      print('Error adding product: $e');
      // Handle the error as needed
    }
  }
}
