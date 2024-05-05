import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nsutbazaar/models/RequestProductModel.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsutbazaar/repositories/firebase_storage_repo.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/requests/bloc/requests_state.dart';
import 'package:nsutbazaar/screens/DrawerScreens/my_requests.dart';
import 'package:nsutbazaar/utils/product_firestore.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/requests/bloc/requests_bloc.dart';
import 'package:nsutbazaar/widgets/core/backgroundContainer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';

class AddRequestScreen extends StatefulWidget {
  const AddRequestScreen({Key? key}) : super(key: key);

  @override
  _AddRequestScreenState createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  String _productName = '';
  double _price = 0.0;
  String _description = '';
  bool isAnonymous = false;

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<FirebaseRepository>();
    final productFirestore =
        new ProductFirestore(authRepository.firebaseFirestore);

    return backgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Add Request'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: WillPopScope(
          onWillPop: () async {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => MyRequests()),
            // );

            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'Product Name',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        ),
                        SizedBox(height: 5.h),
                        Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 36, 28, 41),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Color.fromARGB(255, 74, 56, 87),
                            ),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Ex: Gaming Mouse',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 176, 153, 189),
                                fontSize: 16.sp,
                              ),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                            ),
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _productName = value!;
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Price',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        ),
                        SizedBox(height: 5.h),
                        Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 36, 28, 41),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Color.fromARGB(255, 74, 56, 87),
                            ),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter Price',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 176, 153, 189),
                                fontSize: 16.sp,
                              ),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                            ),
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter price';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _price = double.parse(value!);
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Description',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        ),
                        SizedBox(height: 5.h),
                        Container(
                          height:
                              110.h, // Increase height for description field
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 36, 28, 41),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Color.fromARGB(255, 74, 56, 87),
                            ),
                          ),
                          child: TextFormField(
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Enter Description',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 176, 153, 189),
                                fontSize: 16.sp,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 12.0.h),
                            ),
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter description';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _description = value!;
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Post Anonymously',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        ),
                        //SizedBox(height: 5.h),
                        Transform.scale(
                          scale: 1.sp,
                          child: Switch(
                              value: isAnonymous,
                              onChanged: (value) {
                                setState(() {
                                  isAnonymous = value;
                                });
                              },
                              activeColor: Colors.purple, // Color when switched on
                              activeTrackColor: Colors.purple.shade100, // Track color when switched on
                              inactiveThumbColor: Colors.white, // Thumb color when switched off
                              inactiveTrackColor: Colors.grey.shade400, // Track color when switched off
                              materialTapTargetSize: MaterialTapTargetSize.padded, // Increase tap target size
                              splashRadius: 30, // Increase splash radius
                            ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: SizedBox(
                        height: 48.h,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              DateTime now = DateTime.now();
                              int timestamp = now.millisecondsSinceEpoch;

                              RequestProductModel product = RequestProductModel(
                                rpid: authRepository.userModel.uid +
                                    timestamp.toString(),
                                userid: authRepository.userModel.uid,
                                productName: _productName,
                                price: _price,
                                description: _description,
                                timestamp: timestamp.toString(),
                                contact: authRepository.userModel.phoneNumber,
                                profileImg: authRepository.userModel.profileImg,
                                username: authRepository.userModel.username,
                                isAnonymous: isAnonymous
                              );

                              productFirestore.addRequestProduct(product);
                            }

                            Navigator.pop(context);
                            context
                                .read<RequestsBloc>()
                                .emit(RequestsStateInitial());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PurpleTheme.ButtonLightPurpleColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
