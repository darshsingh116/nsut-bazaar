import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              placeholder: (context, url) => Image.asset(
                'assets/loading.gif', // Placeholder image asset
                fit: BoxFit.contain,
                width: 50.w, // Specify the width of the placeholder
                height: 10.h, // Specify the height of the placeholder
              ),
              imageUrl: sellProductModel.imageUrl,
              width: 300.w,
              height: 150.h,
              fit: BoxFit.cover,
            ),
          )
// ,
//           SizedBox(
//             height: 5.h,
//           ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 5.w),
          //   child: Text(
          //     sellProductModel.productName.toTitleCase(),
          //     style: TextStyle(
          //         fontSize: 16.sp,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.white),
          //   ),
          // ),
        ],
      ),
    );
  }
}
