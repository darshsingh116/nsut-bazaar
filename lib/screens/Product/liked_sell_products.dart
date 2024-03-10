// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nsutbazaar/models/SellProductModel.dart';
import 'package:nsutbazaar/repositories/local_data.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_state.dart';
import 'package:nsutbazaar/screens/Product/product_details.dart';
import 'package:nsutbazaar/widgets/cards/sell_listing_card.dart';
import 'package:nsutbazaar/widgets/core/backgroundContainer.dart';
import 'package:nsutbazaar/widgets/core/secondary_appBar.dart';

class LikedSellProductScreen extends StatefulWidget {
  LocalData localData;
  LikedSellProductScreen({
    Key? key,
    required this.localData,
  }) : super(key: key);
  @override
  _LikedSellProductScreenState createState() => _LikedSellProductScreenState();
}

class _LikedSellProductScreenState extends State<LikedSellProductScreen> {
  @override
  Widget build(BuildContext context) {
    final listingsBloc = context.read<ListingsBloc>();
    final localData = context.read<LocalData>();

    return WillPopScope(
      onWillPop: () async {
        listingsBloc.emit(ListingsStateInitial());
        return true; // Allow back navigation
      },
      child: backgroundContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: secondaryAppBar("Liked", context),
          body: (widget.localData.likedSellProductModelList.length > 0)
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two items in a row
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height /
                            1.7), // Adjust as needed
                  ),
                  itemCount: widget.localData.likedSellProductModelList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final SellProductModel product =
                        widget.localData.likedSellProductModelList[index];
                    return GestureDetector(
                      onTap: () {
                         Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetails(
                                                        product: product,
                                                        localData: localData,
                                                      )),
                                            );
                      },
                      child: SellListCard(
                        sellProductModel: product,
                        localData: widget.localData,
                      ),
                    );
                  },
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100.h,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 20.w, 10.h),
                        child: SvgPicture.asset(
                          'assets/liked.svg',
                          semanticsLabel: 'An SVG image',
                          width: 400.w,
                          height: 370.h,
                        ),
                      ),
                      Text(
                        "No Liked Items",
                        style: TextStyle(color: Colors.white, fontSize: 20.sp),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
