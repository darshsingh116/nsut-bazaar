// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/extensions/strings.dart';
import 'package:nsutbazaar/models/RequestProductModel.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/requests/bloc/requests_bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/requests/bloc/requests_event.dart';
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

  void updateData() {
    final firebaseRepository = context.read<FirebaseRepository>();
    final productFirestore =
        ProductFirestore(firebaseRepository.firebaseFirestore);

    setState(() {
      _productsFuture = productFirestore
          .getAllRequestProductsByUserId(firebaseRepository.userModel.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final firebaseRepository = context.read<FirebaseRepository>();
    final productFirestore =
        ProductFirestore(firebaseRepository.firebaseFirestore);
    final requestsBloc = context.read<RequestsBloc>();

    return backgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('My Requests',style: TextStyle(fontSize: 18.sp ,fontWeight: FontWeight.bold ),),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: PurpleTheme.PurpleColor,
        //   onPressed: () {
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(builder: (context) => AddRequestScreen()),
        //     );
        //   },
        //   child: const Icon(Icons.add),
        // ),
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
                  child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60.h,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 20.w, 5.h),
                        child: SvgPicture.asset(
                          'assets/nothing_here.svg',
                          semanticsLabel: 'An SVG image',
                          height: 300.h,
                        ),
                      ),
                      Text(
                        "Nothing Here",
                        style: TextStyle(color: Colors.white, fontSize: 20.sp,fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    RequestProductModel product = snapshot.data![index];

                    return MyRequestCard(
                      requestProductModel: product,
                      updateData: updateData,
                      productFirestore: productFirestore,
                      requestsBloc: requestsBloc,
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
  Function updateData;
  ProductFirestore productFirestore;
  RequestsBloc requestsBloc;

  MyRequestCard({
    Key? key,
    required this.requestProductModel,
    required this.updateData,
    required this.productFirestore,
    required this.requestsBloc,
  }) : super(key: key);

  @override
  _MyRequestCardState createState() => _MyRequestCardState();
}

class _MyRequestCardState extends State<MyRequestCard> {
  @override
  Widget build(BuildContext context) {
    final firebaseRepository = context.read<FirebaseRepository>();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 16.w),
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
                    widget.requestProductModel.productName.toTitleCase(),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   width: 85.w,
                //   height: 35.h,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8.r),
                //     color: PurpleTheme.ButtonLightPurpleColor,
                //   ),
                //   child: TextButton(
                //     onPressed: () {
                //       // Edit button action
                //     },
                //     child: Text(
                //       'Edit',
                //       style: TextStyle(color: Colors.white),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 5.h),
                Container(
                  width: 85.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: PurpleTheme.ButtonDarkPurpleColor,
                  ),
                  child: TextButton(
                    onPressed: () async {
                      await widget.productFirestore.deleteRequestProduct(
                          widget.requestProductModel.rpid);
                      widget.requestsBloc.add(RequestsEventInitialize(
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
