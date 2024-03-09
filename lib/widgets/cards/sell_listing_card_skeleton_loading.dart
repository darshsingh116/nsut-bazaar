import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/extensions/strings.dart';
import 'package:nsutbazaar/models/SellProductModel.dart';
import 'package:nsutbazaar/repositories/local_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_skeleton_niu/loading_skeleton.dart';

class SellListCardSkeletonLoading extends StatefulWidget {
  @override
  _SellListCardState createState() => _SellListCardState();
}

class _SellListCardState extends State<SellListCardSkeletonLoading> {


  @override
  Widget build(BuildContext context) {
    double containerWidth = 175.w;

    return Container(
        width: containerWidth,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.transparent,
                height: 165.h,
                width: containerWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: LoadingSkeleton(
                      width: double.infinity,
                      height: double.infinity,
                      colors: PurpleTheme.greyLoadingShadesColors,
                      animationDuration: 2000,
                    ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                width: containerWidth,
                height: 52.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
  padding: EdgeInsets.symmetric(vertical: 2.h),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(10.r), // Adjust the radius as needed
    child: LoadingSkeleton(
      width: double.infinity,
      height: 20.h,
      colors: PurpleTheme.greyLoadingShadesColors,
      animationDuration: 2000,
    ),
  ),
),
Padding(
  padding: EdgeInsets.symmetric(vertical: 2.h),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(10.r), // Adjust the radius as needed
    child: LoadingSkeleton(
      width: 50.w,
      height: 20.h,
      colors: PurpleTheme.greyLoadingShadesColors,
      animationDuration: 2000,
    ),
  ),
),

                  ],
                ),
              ),
            ]));
  }
}
