import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nsutbazaar/models/ProductModel.dart'; // Import your ProductModel
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/utils/product_firestore.dart';
import 'package:nsutbazaar/widgets/backgroundContainer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListingsScreen extends StatefulWidget {
  const ListingsScreen({Key? key}) : super(key: key);

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  late Future<List<ProductModel>> _productsFuture; // Declare future

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Call function to fetch products
  }

  // Function to fetch products
  void _fetchProducts() {
    final authRepository = context.read<FirebaseRepository>();
    final productFirestore = ProductFirestore(authRepository.firebaseFirestore);

    // Set the future to fetch products
    _productsFuture = productFirestore.getAllSellProducts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Call fetchProducts method when dependencies change
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: FutureBuilder<List<ProductModel>>(
          future: _productsFuture, // Use the future variable
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
