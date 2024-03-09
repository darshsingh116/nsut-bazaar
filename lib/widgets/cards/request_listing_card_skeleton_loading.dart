import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_skeleton_niu/loading_skeleton.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/extensions/strings.dart';
import 'package:nsutbazaar/models/RequestProductModel.dart';

class RequestListCardSkeletonLoading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      height: 110.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 48.h,
              width: 48.w,
              decoration: BoxDecoration(
                color: PurpleTheme.PurpleColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
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
              width: 16.w,
            ),
            SizedBox(
              width: 250.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: LoadingSkeleton(
                      width: double.infinity,
                      height: 20.h,
                      colors: PurpleTheme.greyLoadingShadesColors,
                      animationDuration: 2000,
                    ),
                ),
                SizedBox(height: 5.h,),
                  ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: LoadingSkeleton(
                      width: 100.w,
                      height: 15.h,
                      colors: PurpleTheme.greyLoadingShadesColors,
                      animationDuration: 2000,
                    ),
                ),
                SizedBox(height: 5.h,),
                  ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: LoadingSkeleton(
                      width: 300.w,
                      height: 15.h,
                      colors: PurpleTheme.greyLoadingShadesColors,
                      animationDuration: 2000,
                    ),
                ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
