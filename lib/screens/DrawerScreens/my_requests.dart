import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/models/RequestProductModel.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/screens/DrawerScreens/add_request.dart';
import 'package:nsutbazaar/utils/product_firestore.dart';
import 'package:nsutbazaar/widgets/core/backgroundContainer.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({Key? key}) : super(key: key);

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  late Future<List<RequestProductModel>> _productsFuture;

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
        ProductFirestore(firebaseRepository.firebaseFirestore);

    return backgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('My Listings'),
          backgroundColor: Colors.transparent,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: PurpleTheme.PurpleColor,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AddRequestScreen()),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: FutureBuilder<List<RequestProductModel>>(
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
                    RequestProductModel product = snapshot.data![index];

                    return MyRequestCard(
                      requestProductModel: product,
                    );
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

class MyRequestCard extends StatefulWidget {
  final RequestProductModel requestProductModel;

  const MyRequestCard({Key? key, required this.requestProductModel})
      : super(key: key);

  @override
  _MyRequestCardState createState() => _MyRequestCardState();
}

class _MyRequestCardState extends State<MyRequestCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Container(
        height: 75.h,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.requestProductModel.productName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Price: ₹${widget.requestProductModel.price}',
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
                    onPressed: () {
                      // Remove button action
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
