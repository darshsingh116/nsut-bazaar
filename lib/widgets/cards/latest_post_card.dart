import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_skeleton_niu/loading_skeleton.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/extensions/strings.dart';
import 'package:nsutbazaar/models/SellProductModel.dart';

class LatestPostCards extends StatelessWidget {
  final SellProductModel sellProductModel;

  LatestPostCards({required this.sellProductModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius:
                BorderRadius.circular(10.0), // Adjust the radius as needed
            child: CachedNetworkImage(
              placeholder: (context, url) => LoadingSkeleton(
                width: double.infinity,
                height: double.infinity,
                colors: PurpleTheme.greyLoadingShadesColors,
                animationDuration: 2000,
              ),
              errorWidget: (context, url, error) => LoadingSkeleton(
                width: double.infinity,
                height: double.infinity,
                colors: PurpleTheme.greyLoadingShadesColors,
                animationDuration: 2000,
              ),
              imageUrl: sellProductModel.imageUrl,
              width: 225.w,
              height: 150.h,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
