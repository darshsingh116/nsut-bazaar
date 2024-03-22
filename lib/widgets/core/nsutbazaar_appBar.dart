import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/models/TagItem.dart';
import 'package:nsutbazaar/repositories/local_data.dart';
import 'package:nsutbazaar/screens/DrawerScreens/add_listing.dart';
import 'package:nsutbazaar/screens/DrawerScreens/add_request.dart';
import 'package:nsutbazaar/screens/Product/liked_sell_products.dart';

PreferredSize nsutbazaarAppBar(BuildContext context) {
  final localData = context.read<LocalData>();

  return PreferredSize(
    preferredSize: Size.fromHeight(40.h),
    child: AppBar(
      titleSpacing: 0,
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 18.w, right: 5.w, top: 5.h), // Add top padding here
            child: SvgPicture.asset(
              'assets/nsut_bazaar_logo_no_bg.svg', // Replace 'your_svg_icon.svg' with your SVG icon asset path
              width: 26.w,
              height: 23.h,
              //color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.h), // Add top padding here
            child: Text(
              "NSUT Bazaar",
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding:
              EdgeInsets.only(right: 18.w, top: 5.h), // Add top padding here
          child: CircleAvatar(
            radius: 15.r,
            backgroundImage: NetworkImage(
                "https://garden.spoonflower.com/c/13819748/p/f/m/-SktcU6WmOgCCdF65VFmRkbYWFKIdMcOgNOef0EplNEDFLCWX1jHTF4/Solid%20Light%20Gray%20color%20for%20the%20Botanical%20Boho%20Collection.jpg"),
          ),
        ),
      ],
      iconTheme: IconThemeData(color: Colors.white, size: 24.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      toolbarHeight: MediaQuery.of(context).size.height * 0.07,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}
