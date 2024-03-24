import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/repositories/local_data.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/home/bloc/home_bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/home/bloc/home_event.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/home/bloc/home_state.dart';
import 'package:nsutbazaar/screens/DrawerScreens/my_listings.dart';
import 'package:nsutbazaar/screens/DrawerScreens/my_requests.dart';
import 'package:nsutbazaar/screens/Product/liked_sell_products.dart';
import 'package:nsutbazaar/utils/product_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final localData = context.read<LocalData>();
    final firebaseRepository = context.read<FirebaseRepository>();
    ;
    final homeBloc = context.read<HomeBloc>();
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeInitial) {
                  homeBloc.add(
                      HomeEventGetData(firebaseRepository: firebaseRepository));
                }
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h), // 15 vertical units of height
                      Container(
                        width: 325.w,
                        height: 150.h,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20.r),
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/sell_banner.png'), // Replace 'your_image.png' with your image asset path
                            fit: BoxFit.cover, // Adjust the fit as needed
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h), // 15 vertical units of height
                      Text(
                        "Activity",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 15.h), // 15 vertical units of height
                      Container(
                        width: 325.w,
                        height: 70.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyListings(),
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: 90.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/myListing.svg',
                                        height: 47.h),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      "My Listings",
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 2,
                              height: 46.h,
                              color: Colors.white,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LikedSellProductScreen(
                                      localData: localData,
                                    ),
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: 70.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/likedIcon.svg',
                                        height: 49.h),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Center(
                                      child: Text(
                                        "Liked",
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 2,
                              height: 46.h,
                              color: Colors.white,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyRequests(),
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: 80.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/myRequest.svg',
                                        height: 43.h),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      "My Requests",
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h), // 15 vertical units of height
                      // Text(
                      //   "Categories",
                      //   style: TextStyle(
                      //       fontSize: 15.sp,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.white),
                      // ),
                      // SizedBox(height: 0.h), // 15 vertical units of height
                      // Container(
                      //   width: 316.w,
                      //   height: 83.h,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Icon(Icons.menu_book,
                      //               size: 45.w, color: Colors.deepPurple),
                      //           SizedBox(
                      //               height: 5.h), // 10 vertical units of height
                      //           Padding(
                      //             padding: EdgeInsets.fromLTRB(0, 0, 2.w, 0),
                      //             child: Text("Books",
                      //                 style: TextStyle(
                      //                     fontSize: 12.sp,
                      //                     fontWeight: FontWeight.w500,
                      //                     color: Colors.white)),
                      //           ),
                      //         ],
                      //       ),
                      //       Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Icon(Icons.sports_basketball,
                      //               size: 45.w, color: Colors.deepPurple),
                      //           SizedBox(
                      //               height: 5.h), // 10 vertical units of height
                      //           Text("Sports",
                      //               style: TextStyle(
                      //                   fontSize: 12.sp,
                      //                   fontWeight: FontWeight.w500,
                      //                   color: Colors.white)),
                      //         ],
                      //       ),
                      //       Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Icon(Icons.school,
                      //               size: 45.w, color: Colors.deepPurple),
                      //           SizedBox(
                      //               height: 5.h), // 10 vertical units of height
                      //           Padding(
                      //             padding: EdgeInsets.fromLTRB(2.w, 0, 0, 0),
                      //             child: Text("Academic",
                      //                 style: TextStyle(
                      //                     fontSize: 12.sp,
                      //                     fontWeight: FontWeight.w500,
                      //                     color: Colors.white)),
                      //           ),
                      //         ],
                      //       ),
                      //       Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Icon(Icons.category,
                      //               size: 45.w, color: Colors.deepPurple),
                      //           SizedBox(
                      //               height: 5.h), // 10 vertical units of height
                      //           Text("Others",
                      //               style: TextStyle(
                      //                   fontSize: 12.sp,
                      //                   fontWeight: FontWeight.w500,
                      //                   color: Colors.white)),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        width: 318.w,
                        height: 102.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xFFFF5944),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 36.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5.r),
                                      bottomRight: Radius.circular(5.r)),
                                  color: Color(0xFFDD4B39),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocBuilder<HomeBloc, HomeState>(
                                      builder: (context, state) {
                                        if (state is HomeGotData) {
                                          return Text(
                                            state.data["sellProductsCount"]
                                                .toString(),
                                            style: GoogleFonts.saira(
                                                fontSize: 45.sp,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          );
                                        }
                                        return Text(
                                          "...",
                                          style: GoogleFonts.saira(
                                              fontSize: 45.sp,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      "Total Posts",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 50.w,
                                ),
                                SvgPicture.asset(
                                  'assets/totalPost.svg', // Replace 'your_svg_icon.svg' with your SVG icon asset path
                                  height: 84.h,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15.h),
                      SizedBox(
                        width: 318.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 149.w,
                              height: 97.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: Color(0xFF02C56C),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 37.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5.r),
                                            bottomRight: Radius.circular(5.r)),
                                        color: Color(0xFF00A65A),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 5.h, 5.w, 0),
                                                child: SvgPicture.asset(
                                                  'assets/totalRequest.svg', // Replace 'your_svg_icon.svg' with your SVG icon asset path
                                                  height: 40.h,
                                                ),
                                              ),
                                              BlocBuilder<HomeBloc, HomeState>(
                                                builder: (context, state) {
                                                  if(state is HomeGotData){
                                                    return Text(
                                                    state.data["requestProductCount"].toString(),
                                                    style: GoogleFonts.saira(
                                                        fontSize: 45.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black),
                                                  );
                                                  }
                                                  return Text(
                                                    "..",
                                                    style: GoogleFonts.saira(
                                                        fontSize: 45.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            "Total Requests",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 149.w,
                              height: 97.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: Color(0xFF53BFFF),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 37.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5.r),
                                            bottomRight: Radius.circular(5.r)),
                                        color: Color(0xFF4AAFE9),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              BlocBuilder<HomeBloc,
                                                  HomeState>(
                                                builder: (context, state) {
                                                  if(state is HomeGotData){
                                                    return Text(
                                                    state.data["todaySellProductsCount"].toString(),
                                                    style: GoogleFonts.saira(
                                                        fontSize: 45.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black),
                                                  );
                                                  }
                                                  return Text(
                                                    "..",
                                                    style: GoogleFonts.saira(
                                                        fontSize: 45.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black),
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 5.h, 0, 0),
                                                child: SvgPicture.asset(
                                                  'assets/postToday.svg', // Replace 'your_svg_icon.svg' with your SVG icon asset path
                                                  height: 40.h,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            "Posts Today",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
