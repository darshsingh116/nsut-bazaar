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
    double containerWidth = 160.w;
    double containerHeight = 176.h;


    return Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                  children: [
                    CircleAvatar(
                      radius: 10.0.r, // Radius of the circular avatar
                      backgroundColor: Colors.grey, // Example background color
                    ),
                    SizedBox(width: 8.0), // Add spacing between avatar and text
                    Text(
                      'Anonymous',
                      style: TextStyle(
                        fontSize: 10.0.sp, // Font size of the text
                        fontWeight: FontWeight.bold, // Bold text
                        color: Colors.white, // Text color
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
              Container(
                color: Colors.transparent,
                height: 95.h,
                  width: 150.w,
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
