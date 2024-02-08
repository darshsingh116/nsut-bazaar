import 'package:flutter/material.dart';
import 'package:nsutbazaar/models/ProductModel.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/screens/DrawerScreens/add_listing.dart';
import 'package:nsutbazaar/screens/DrawerScreens/add_request.dart';
import 'package:nsutbazaar/utils/product_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({Key? key}) : super(key: key);

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests>{
  late Future<List<ProductModel>> _productsFuture; 

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }



  // Function to fetch products
  void _fetchProducts() {
    final firebaseRepository = context.read<FirebaseRepository>();
    final productFirestore =
        ProductFirestore(firebaseRepository.firebaseFirestore);

      _productsFuture = productFirestore
          .getAllRequestProductsByUserId(firebaseRepository.userModel.uid);
    
  }

  @override
  Widget build(BuildContext context) {
    final firebaseRepository = context.read<FirebaseRepository>();
    final productFirestore =
        new ProductFirestore(firebaseRepository.firebaseFirestore);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Listings'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddRequestScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: FutureBuilder<List<ProductModel>>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No products available'),
              );
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  ProductModel product = snapshot.data![index];
                  print(product.productName);
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Product Name: ${product.productName}'),
                        Text('Price: ${product.price}'),
                        Text('Description: ${product.description}'),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
