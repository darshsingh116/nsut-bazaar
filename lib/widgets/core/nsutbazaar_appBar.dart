import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/models/TagItem.dart';
import 'package:nsutbazaar/repositories/local_data.dart';
import 'package:nsutbazaar/screens/DrawerScreens/add_listing.dart';
import 'package:nsutbazaar/screens/DrawerScreens/add_request.dart';
import 'package:nsutbazaar/screens/Product/liked_sell_products.dart';

PreferredSize nsutbazaarAppBar(MyTabItem myTabItem, BuildContext context) {
  final localData = context.read<LocalData>();

  Future<void> InfoDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('NsutBazaar App Info'),
          content: const Text(
            'This app belongs to NsutBazaar society.\n'
            'For more info contact techNsutBazaar@gmail.com\n',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  return PreferredSize(
    preferredSize: Size.fromHeight(52.h),
    child: AppBar(
      title: Text(
        myTabItem.title,
        style: TextStyle(fontSize: 18.sp),
        textAlign: TextAlign.left,
      ),
      iconTheme: IconThemeData(color: Colors.white, size: 24.sp),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft:
            Radius.circular(0), // Adjust the radius to control corner shape
        bottomRight: Radius.circular(0),
      )),
      toolbarHeight: MediaQuery.of(context).size.height * 0.07,
      centerTitle: myTabItem.centerTitle,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: myTabItem.centerTitle
          ? []
          : (<Widget>[
              (myTabItem.title == "Listings")
                  ? (GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
                        child: Icon(
                          Icons.favorite_border,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          size: 24.sp,
                        ),
                      ), //
                      onTap: () async {
                        await localData.updateList();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LikedSellProductScreen(
                                      localData: localData,
                                    )));
                      }))
                  : Container(),
              (myTabItem.title == "Listings" || myTabItem.title == "Requests")?GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 0, 15.w, 0),
                    child: Icon(
                      Icons.add_circle_outline_outlined,
                      size: 24.sp,
                    ),
                  ),
                  onTap: () => (myTabItem.title == "Listings")
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddListingScreen()))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddRequestScreen()))):Container(),
            ]),
    ),
  );
}
