import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/extensions/strings.dart';
import 'package:nsutbazaar/models/SellProductModel.dart';
import 'package:nsutbazaar/repositories/local_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_skeleton_niu/loading_skeleton.dart';

class SellListCard extends StatefulWidget {
  final SellProductModel sellProductModel;
  final LocalData localData;

  const SellListCard(
      {super.key, required this.sellProductModel, required this.localData});

  @override
  _SellListCardState createState() => _SellListCardState();
}

class _SellListCardState extends State<SellListCard> {
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      print(widget.localData.likedSellProductModelList
          .any((item) => item.imageUrl == widget.sellProductModel.imageUrl));
      _isLiked = widget.localData.likedSellProductModelList
          .any((item) => item.imageUrl == widget.sellProductModel.imageUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = 160.w;
    double containerHeight = 176.h;

    return Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          color: Color.fromARGB(0, 255, 18, 18),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10.0.r, // Radius of the circular avatar
                      backgroundColor: Colors.blue, // Example background color
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
                      imageUrl: widget.sellProductModel.imageUrl,
                      fit: BoxFit.fill,
                      fadeInDuration: Duration(
                          milliseconds: 200), // Duration for fade-in animation
                    ),
                  ),
                ),
                Container(
                  width: containerWidth,
                  height: 52.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.sellProductModel.productName.toTitleCase(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '₹${widget.sellProductModel.price.toString()}',
                            style: TextStyle(
                                color: PurpleTheme.LightPurpleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      IconButton(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        icon: Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border,
                          color: _isLiked
                              ? PurpleTheme.LightPurpleColor
                              : Colors.white,
                          size: 24.sp,
                        ),
                        onPressed: () {
                          setState(() {
                            _isLiked = !_isLiked;
                            if (_isLiked) {
                              widget.localData.addData(widget.sellProductModel);
                            } else {
                              widget.localData
                                  .removeData(widget.sellProductModel);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ]),
        ));
  }
}
