// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/models/SellProductModel.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/repositories/firebase_storage_repo.dart';
import 'package:nsutbazaar/repositories/local_data.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_event.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_state.dart';
import 'package:nsutbazaar/screens/DrawerScreens/add_listing.dart';
import 'package:nsutbazaar/utils/product_firestore.dart';
import 'package:nsutbazaar/widgets/core/backgroundContainer.dart';

class MyListings extends StatefulWidget {
  const MyListings({Key? key}) : super(key: key);

  @override
  State<MyListings> createState() => _MyListingsState();
}

class _MyListingsState extends State<MyListings> {
  late Future<List<SellProductModel>> _productsFuture; // Declare future

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Call function to fetch products
  }

  // Function to fetch products
  void _fetchProducts() {
    final firebaseRepository = context.read<FirebaseRepository>();

    final productFirestore =
        ProductFirestore(firebaseRepository.firebaseFirestore);

    // Set the future to fetch products based on the user ID
    _productsFuture = productFirestore
        .getAllSellProductsByUserId(firebaseRepository.userModel.uid);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Call fetchProducts method when dependencies change
    _fetchProducts();
  }

  void updateData() {
    final firebaseRepository = context.read<FirebaseRepository>();
    final productFirestore =
        ProductFirestore(firebaseRepository.firebaseFirestore);

    setState(() {
      _productsFuture = productFirestore
          .getAllSellProductsByUserId(firebaseRepository.userModel.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final firebaseRepository = context.read<FirebaseRepository>();
    final productFirestore =
        new ProductFirestore(firebaseRepository.firebaseFirestore);
    final listingsBloc = context.read<ListingsBloc>();

    return backgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'My Listings',
            style: TextStyle(fontSize: 18.sp),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: PurpleTheme.PurpleColor,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AddListingScreen()),
            );
          },
          child: Icon(
            Icons.add,
          ),
        ),
        body: SafeArea(
          child: FutureBuilder<List<SellProductModel>>(
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
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    SellProductModel product = snapshot.data![index];
                    print(product.productName);

                    return MyListingCard(
                      sellProductModel: product,
                      productFirestore: productFirestore,
                      listingsBloc: listingsBloc,
                      updateData: updateData,
                    );

                    // return Card(
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Image.network(
                    //         product
                    //             .imageUrl, // Replace with the actual image URL
                    //         width: double.infinity, // Adjust width as needed
                    //         height: 150, // Adjust height as needed
                    //         fit: BoxFit.cover, // Adjust image fit
                    //       ),
                    //       Text('Product Name: ${product.productName}'),
                    //       Text('Price: ${product.price}'),
                    //       Text('Description: ${product.description}'),
                    //     ],
                    //   ),
                    // );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class MyListingCard extends StatefulWidget {
  Function updateData;
  SellProductModel sellProductModel;
  ProductFirestore productFirestore;
  ListingsBloc listingsBloc;
  MyListingCard({
    Key? key,
    required this.updateData,
    required this.sellProductModel,
    required this.productFirestore,
    required this.listingsBloc,
  }) : super(key: key);
  @override
  State<MyListingCard> createState() => _MyListingCardState();
}

class _MyListingCardState extends State<MyListingCard> {
  @override
  Widget build(BuildContext context) {
    final firebaseRepository = context.read<FirebaseRepository>();
    final firebaseStoreageRepo = context.read<FirebaseStorageRepo>();
    final localData = context.read<LocalData>();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Container(
        height: 75.h,
        child: Row(
          children: [
            Container(
              width: 56.w,
              height: 75.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.white, // You can set background color if needed
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  widget
                      .sellProductModel.imageUrl, // Replace with your image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.sellProductModel.productName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Price: ₹${widget.sellProductModel.price}',
                    style: TextStyle(
                        color: PurpleTheme.LightPurpleColor, fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 85.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: PurpleTheme.ButtonLightPurpleColor,
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Edit button action
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  width: 85.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: PurpleTheme.ButtonDarkPurpleColor,
                  ),
                  child: TextButton(
                    onPressed: () async {
                      await widget.productFirestore.deleteSellProduct(
                          widget.sellProductModel, firebaseStoreageRepo);
                      widget.listingsBloc.add(ListingsEventInitialize(
                          firebaseRepository: firebaseRepository));
                      widget.updateData();
                    },
                    child: Text(
                      'Remove',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
