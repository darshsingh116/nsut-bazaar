import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nsutbazaar/models/SellProductModel.dart';

class LocalData {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  List<SellProductModel> likedSellProductModelList = [];

  LocalData() {
    // Call initialize function when an instance of LocalData is created
    initialize();
  }

  Future<void> initialize() async {
    print("local data init ran");
    // Load data from secure storage
    String? jsonData = await _storage.read(key: 'sellProductModelList');
    if (jsonData != null) {
      // If data exists, parse it and set the list
      Iterable parsedJson = jsonDecode(jsonData);
      likedSellProductModelList = List<SellProductModel>.from(
          parsedJson.map((model) => SellProductModel.fromMap(model)));
    }
  }

  // Future<void> updateData() async {
  //   // Convert SellProductModelList to JSON
  //   String jsonData = jsonEncode(sellProductModelList);
  //   // Store data in secure storage
  //   await _storage.write(key: 'sellProductModelList', value: jsonData);
  // }

  Future<void> addData(SellProductModel sellProductModel) async {
    likedSellProductModelList.add(sellProductModel);
    for (SellProductModel product in likedSellProductModelList) {
      print('Product Name: ${product.productName}');
    }
    print("~~~~~~~~~~~~~~~~~~~~");
    // Convert SellProductModelList to JSON
    String jsonData = jsonEncode(likedSellProductModelList);
    // Store data in secure storage
    await _storage.write(key: 'sellProductModelList', value: jsonData);
  }

  Future<void> removeData(SellProductModel sellProductModel) async {
    likedSellProductModelList
        .removeWhere((product) => product.imageUrl == sellProductModel.imageUrl);
    for (SellProductModel product in likedSellProductModelList) {
      print('Product Name: ${product.productName}');
    }

    print("~~~~~~~~~~~~~~~~~~~~");
    // Convert SellProductModelList to JSON
    String jsonData = jsonEncode(likedSellProductModelList);
    // Store data in secure storage
    await _storage.write(key: 'sellProductModelList', value: jsonData);
  }
}
