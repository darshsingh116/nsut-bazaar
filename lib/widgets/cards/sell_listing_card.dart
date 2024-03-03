import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/extensions/strings.dart';
import 'package:nsutbazaar/models/SellProductModel.dart';
import 'package:nsutbazaar/repositories/local_data.dart';

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
    // TODO: implement initState
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
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = 175.w;
    //double containerHeight = screenHeight / 6;

    return Container(
        width: containerWidth,
        decoration: BoxDecoration(
          color: Colors.transparent,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(5),
          //   topRight: Radius.circular(5),
          //   bottomLeft: Radius.circular(5),
          //   bottomRight: Radius.circular(5),
          // ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.transparent,
                height: 216.h,
                width: containerWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: FadeInImage.assetNetwork(
                    placeholder:
                        'assets/loading.gif', // Placeholder image asset
                    image: widget.sellProductModel.imageUrl,
                    fit: BoxFit.fill,
                    fadeInDuration: Duration(
                        milliseconds: 200), // Duration for fade-in animation
                    width: 10.w, // Specify the width of the placeholder
                    height: 10.h, // Specify the height of the placeholder
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
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
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '₹${widget.sellProductModel.price.toString()}',
                          style: TextStyle(
                              color: PurpleTheme.LightPurpleColor,
                              fontSize: 14.sp),
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
            ]));
  }
}
