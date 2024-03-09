import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_skeleton_niu/loading_skeleton.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/extensions/strings.dart';
import 'package:nsutbazaar/models/SellProductModel.dart';

class LatestPostCardsSkeletonLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius:
                BorderRadius.circular(10.0), // Adjust the radius as needed
            child: LoadingSkeleton(
                      width: 300.h,
                      height: 150.h,
                      colors: PurpleTheme.greyLoadingShadesColors,
                      animationDuration: 2000,
                    ),
          )
        ],
      ),
    );
  }
}
