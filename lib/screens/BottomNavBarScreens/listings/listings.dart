import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/models/SellProductModel.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/repositories/local_data.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_event.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_state.dart';
import 'package:nsutbazaar/screens/Product/product_details.dart';
import 'package:nsutbazaar/widgets/cards/latest_post_card.dart';
import 'package:nsutbazaar/widgets/cards/latest_post_card_skeleton_loading.dart';
import 'package:nsutbazaar/widgets/cards/sell_listing_card.dart';
import 'package:nsutbazaar/widgets/cards/sell_listing_card_skeleton_loading.dart';
import 'package:nsutbazaar/widgets/tagButton.dart';
import 'package:flutter_sticky_widgets/flutter_sticky_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ListingsScreen extends StatefulWidget {
  const ListingsScreen({Key? key}) : super(key: key);

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  late ScrollController _parentScrollController;
  // late ScrollController _childScrollController;

  // bool _isParentScrollingEnabled = true;
  // bool _isChildScrollingEnabled = false;

  Map<String, bool> TagButtonsIsSelected = {
    'All': true,
    'Books': false,
    'Others': false,
    'Sports': false,
    'Academic tools': false,
  };

  List<SellProductModel> LatestPostList = [];
  @override
  void initState() {
    super.initState();
    _parentScrollController = ScrollController();
    //   _childScrollController = ScrollController();
    //   _parentScrollController.addListener(_onParentScroll);
    //   _childScrollController.addListener(_onChildScroll);
  }

  @override
  void dispose() {
    _parentScrollController.dispose();
    //_childScrollController.dispose();
    super.dispose();
  }

  // void _onParentScroll() {
  //   if (_parentScrollController.offset >=
  //       _parentScrollController.position.maxScrollExtent) {
  //     setState(() {
  //       _isChildScrollingEnabled = true;
  //       _childScrollController.jumpTo(_childScrollController.offset + 0.01);
  //       //_childScrollController = _parentScrollController;
  //     });
  //   }
  // }

  // void _onChildScroll() {
  //   if (_childScrollController.position.pixels <=
  //       _childScrollController.position.minScrollExtent) {
  //     setState(() {
  //       _isParentScrollingEnabled = true;
  //       _parentScrollController.jumpTo(_parentScrollController.offset -
  //           0.01); // Push the parent up by 10 pixels
  //       _isChildScrollingEnabled = false;
  //     });
  //   }
  // }

  void updateSelectedTag(String title) {
    setState(() {
      TagButtonsIsSelected.forEach((key, value) {
        TagButtonsIsSelected[key] = (key == title);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final listingsBloc = context.read<ListingsBloc>();
    final firebaseRepository = context.read<FirebaseRepository>();
    final localData = context.read<LocalData>();
    double containerWidth = 175.w;
    double containerHeight = 240.h;

    final List<Widget> tagButtonsList = [
      TagButtons(
          title: "All",
          isSelected: TagButtonsIsSelected['All']!,
          updateSelectedTag: updateSelectedTag),
      TagButtons(
          title: "Books",
          isSelected: TagButtonsIsSelected['Books']!,
          updateSelectedTag: updateSelectedTag),
      TagButtons(
          title: "Sports",
          isSelected: TagButtonsIsSelected['Sports']!,
          updateSelectedTag: updateSelectedTag),
      TagButtons(
          title: "Academic tools",
          isSelected: TagButtonsIsSelected['Academic tools']!,
          updateSelectedTag: updateSelectedTag),
      TagButtons(
          title: "Others",
          isSelected: TagButtonsIsSelected['Others']!,
          updateSelectedTag: updateSelectedTag),
    ];

    return BlocConsumer<ListingsBloc, ListingsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ListingsStateInitial) {
          print("here");
          //print(localData.)
          listingsBloc.add(ListingsEventGetAllList(
              firebaseRepository: firebaseRepository, localData: localData));
        }
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                  child: SearchAnchor(builder:
                      (BuildContext context, SearchController controller) {
                    return SearchBar(
                      backgroundColor:
                          MaterialStateProperty.all(PurpleTheme.PurpleColor),
                      hintText: "Search",
                      hintStyle: MaterialStateProperty.all(
                          TextStyle(color: PurpleTheme.LightPurpleColor)),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(color: Colors.white)),
                      controller: controller,
                      padding: MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0.sp)),
                      onChanged: (searchParameter) {
                        listingsBloc.add(ListingsEventGetSearchedList(
                            firebaseRepository: firebaseRepository,
                            searchParameter: searchParameter));
                      },
                      onSubmitted: (searchParameter) {
                        listingsBloc.add(ListingsEventGetSearchedList(
                            firebaseRepository: firebaseRepository,
                            searchParameter: searchParameter));
                      },
                      leading: const Icon(
                        Icons.search,
                        color: PurpleTheme.LightPurpleColor,
                      ),
                    );
                  }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return [
                      SizedBox.shrink()
                    ]; // This will ensure no suggestion bar is shown
                  }),
                ),
                Expanded(
                  child: StickyContainer(
                    displayOverFlowContent: true,
                    stickyChildren: [
                      // StickyWidget(
                      //   initialPosition: StickyPosition(top: 0.h, left: 20.w),
                      //   finalPosition: StickyPosition(top: 0.h, left: 20.w),
                      //   controller: _parentScrollController,
                      //   child: SizedBox(
                      //     width: 350.w,
                      //     height: 75.h,
                      //     child: Padding(
                      //       padding:
                      //           EdgeInsets.symmetric(vertical: 12.h, horizontal: 0.w),
                      //       child: SearchAnchor(builder:
                      //           (BuildContext context, SearchController controller) {
                      //         return SearchBar(
                      //           backgroundColor: MaterialStateProperty.all(
                      //               PurpleTheme.PurpleColor),
                      //           hintText: "Search",
                      //           hintStyle: MaterialStateProperty.all(
                      //               TextStyle(color: PurpleTheme.LightPurpleColor)),
                      //           textStyle: MaterialStateProperty.all(
                      //               TextStyle(color: Colors.white)),
                      //           controller: controller,
                      //           padding: MaterialStatePropertyAll<EdgeInsets>(
                      //               EdgeInsets.symmetric(horizontal: 16.0.sp)),
                      //           onChanged: (searchParameter) {
                      //             listingsBloc.add(ListingsEventGetSearchedList(
                      //                 firebaseRepository: firebaseRepository,
                      //                 searchParameter: searchParameter));
                      //           },
                      //           onSubmitted: (searchParameter) {
                      //             listingsBloc.add(ListingsEventGetSearchedList(
                      //                 firebaseRepository: firebaseRepository,
                      //                 searchParameter: searchParameter));
                      //           },
                      //           leading: const Icon(
                      //             Icons.search,
                      //             color: PurpleTheme.LightPurpleColor,
                      //           ),
                      //         );
                      //       }, suggestionsBuilder:
                      //           (BuildContext context, SearchController controller) {
                      //         return [
                      //           SizedBox.shrink()
                      //         ]; // This will ensure no suggestion bar is shown
                      //       }),
                      //     ),
                      //   ),
                      // )
                      StickyWidget(
                        initialPosition: StickyPosition(top: 190.h, left: 0),
                        finalPosition: StickyPosition(top: -1.h, left: 0),
                        controller: _parentScrollController,
                        child: Container(
                          height: 58.h,
                          width: MediaQuery.of(context).size.width,
                          color: PurpleTheme.DarkPurpleBackgroundColor,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: tagButtonsList
                                  .length, // Adjust this according to your data
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
                                  child: tagButtonsList[index],
                                );
                              }),
                        ),
                      )
                    ],
                    child: SingleChildScrollView(
                      controller: _parentScrollController,
                      child: Column(
                        children: [
                          SizedBox(height: 10.h),
                          
                          // Container(
                          //     height: 180.h,
                          //     width: double.infinity,
                          //     child: Image.asset(
                          //       'assets/printout_coming.png',
                          //       //semanticsLabel: 'An SVG image',
                          //       fit: BoxFit.contain,
                          //     )

                              Container(
                                height: 180.h,
                                width: double.infinity,
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    autoPlayInterval:const Duration(seconds: 4),
                                    
                                    autoPlay: true,
                                    viewportFraction: 1,
                                    //aspectRatio: 2.0,
                                    enlargeCenterPage: true,
                                    enlargeStrategy:
                                        CenterPageEnlargeStrategy.height,
                                        
                                  ),
                                  items: [
                                    SizedBox(
                                      width: 350.w,
                                      height: 180.h,
                                      child: Image.asset(
                                        'assets/printout_coming.png',
                                        //semanticsLabel: 'An SVG image',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 350.w,
                                      height: 180.h,
                                      child: Image.asset(
                                        'assets/sell_banner.png',
                                        //semanticsLabel: 'An SVG image',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 350.w,
                                      height: 180.h,
                                      child: Image.asset(
                                        'assets/request_banner.png',
                                        //semanticsLabel: 'An SVG image',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              // child: BlocBuilder<ListingsBloc, ListingsState>(
                              //   builder: (context, state) {
                              //     if (state is ListingsStateLoading ||
                              //         state is ListingsStateInitial) {
                              //       return Center(
                              //         child: LatestPostCardsSkeletonLoading(),
                              //       );
                              //     } else if (state is ListingsStateGotList ||
                              //         state is ListingsStateGotSearchedList) {
                              //       if (state is ListingsStateGotList) {
                              //         LatestPostList = state.productList;
                              //       }
                              //       if (LatestPostList.isEmpty) {
                              //         return Center(
                              //           child: Text(
                              //             'No products available',
                              //             style: TextStyle(color: Colors.white),
                              //           ),
                              //         );
                              //       } else {
                              //         print("HAAAAAAAAI");
                              //         List<Widget> getCarouselItems(
                              //             List<SellProductModel>
                              //                 sellProductModels,
                              //             BuildContext context,
                              //             dynamic localData) {
                              //           List<Widget> carouselItems = [];

                              //           for (int i = 0;
                              //               i < min(5, sellProductModels.length);
                              //               i++) {
                              //             carouselItems.add(
                              //               Padding(
                              //                 padding: EdgeInsets.symmetric(
                              //                     horizontal: 10.w),
                              //                 child: GestureDetector(
                              //                   onTap: () {
                              //                     Navigator.push(
                              //                       context,
                              //                       MaterialPageRoute(
                              //                         builder: (context) =>
                              //                             ProductDetails(
                              //                           product:
                              //                               sellProductModels[i],
                              //                           localData: localData,
                              //                         ),
                              //                       ),
                              //                     );
                              //                   },
                              //                   child: LatestPostCards(
                              //                     sellProductModel:
                              //                         sellProductModels[i],
                              //                   ),
                              //                 ),
                              //               ),
                              //             );
                              //           }

                              //           return carouselItems;
                              //         }

                              //         List<Widget> carouselItems =
                              //             getCarouselItems(
                              //                 LatestPostList, context, localData);

                              //         return CarouselSlider(
                              //           options: CarouselOptions(
                              //             autoPlay: true,
                              //             //aspectRatio: 2.0,
                              //             enlargeCenterPage: true,
                              //             enlargeStrategy:
                              //                 CenterPageEnlargeStrategy.height,
                              //           ),
                              //           items: carouselItems,
                              //         );

                              //         // return SizedBox(
                              //         //   // Adjust the height as per your requirement
                              //         //   child: ListView.builder(
                              //         //     scrollDirection: Axis.horizontal,
                              //         //     itemCount:
                              //         //         (LatestPostList.length <= 5)
                              //         //             ? LatestPostList.length
                              //         //             : 5,
                              //         //     itemBuilder: (context, index) {
                              //         //       SellProductModel product =
                              //         //           LatestPostList[index];

                              //         //       return Padding(
                              //         //         padding: EdgeInsets.symmetric(
                              //         //             horizontal: 10.w),
                              //         //         child: GestureDetector(
                              //         //           onTap: () {
                              //         //             Navigator.push(
                              //         //               context,
                              //         //               MaterialPageRoute(
                              //         //                 builder: (context) =>
                              //         //                     ProductDetails(
                              //         //                   product: product,
                              //         //                   localData: localData,
                              //         //                 ),
                              //         //               ),
                              //         //             );
                              //         //           },
                              //         //           child: LatestPostCards(
                              //         //             sellProductModel: product,
                              //         //           ),
                              //         //         ),
                              //         //       );
                              //         //     },
                              //         //   ),
                              //         // );
                              //       }
                              //     }
                              //     return Text("Error Out of States");
                              //   },
                              // ),
                              ),
                          // Container(
                          //   height: 58.h,
                          //   child: ListView.builder(
                          //       scrollDirection: Axis.horizontal,
                          //       itemCount: tagButtonsList
                          //           .length, // Adjust this according to your data
                          //       itemBuilder: (BuildContext context, int index) {
                          //         return Padding(
                          //           padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
                          //           child: tagButtonsList[index],
                          //         );
                          //       }),
                          // ),
                          Container(
                            height: 58.h,
                          ),

                          BlocBuilder<ListingsBloc, ListingsState>(
                            builder: (context, state) {
                              if (state is ListingsStateLoading ||
                                  state is ListingsStateInitial) {
                                return Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
                                  child: GridView(
                                    //controller: _parentScrollController,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio:
                                          containerWidth / containerHeight,
                                      crossAxisSpacing: 10.0.w,
                                      mainAxisSpacing: 0.0,
                                    ),
                                    children: [
                                      SellListCardSkeletonLoading(),
                                      SellListCardSkeletonLoading(),
                                      SellListCardSkeletonLoading(),
                                      SellListCardSkeletonLoading(),
                                    ],
                                  ),
                                );
                              } else if (state is ListingsStateGotList ||
                                  state is ListingsStateGotSearchedList) {
                                List<SellProductModel> list = [];
                                if (state is ListingsStateGotList) {
                                  list = state.productList;
                                } else if (state
                                    is ListingsStateGotSearchedList) {
                                  list = state.productList;
                                }
                                if (list.isEmpty) {
                                  return Text(
                                    'No products available',
                                    style: TextStyle(color: Colors.white),
                                  );
                                } else {
                                  list.shuffle();
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        10.w, 10.h, 10.w, 0),
                                    child: GridView.builder(
                                      //controller: _parentScrollController,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio:
                                            containerWidth / containerHeight,
                                        crossAxisSpacing: 10.0.w,
                                        mainAxisSpacing: 0.0,
                                      ),
                                      itemCount: list.length,
                                      itemBuilder: (context, index) {
                                        SellProductModel product = list[index];

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
                                            localData: localData,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                              }
                              return Text("Error Out of States");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.1,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}
























// Padding(
//                   padding:
//                       EdgeInsets.symmetric(vertical: 12.h, horizontal: 30.w),
//                   child: SearchAnchor(builder:
//                       (BuildContext context, SearchController controller) {
//                     return SearchBar(
//                       backgroundColor:
//                           MaterialStateProperty.all(PurpleTheme.PurpleColor),
//                       hintText: "Search",
//                       hintStyle: MaterialStateProperty.all(
//                           TextStyle(color: PurpleTheme.LightPurpleColor)),
//                       textStyle: MaterialStateProperty.all(
//                           TextStyle(color: Colors.white)),
//                       controller: controller,
//                       padding: MaterialStatePropertyAll<EdgeInsets>(
//                           EdgeInsets.symmetric(horizontal: 16.0.sp)),
//                       onChanged: (searchParameter) {
//                         listingsBloc.add(ListingsEventGetSearchedList(
//                             firebaseRepository: firebaseRepository,
//                             searchParameter: searchParameter));
//                       },
//                       onSubmitted: (searchParameter) {
//                         listingsBloc.add(ListingsEventGetSearchedList(
//                             firebaseRepository: firebaseRepository,
//                             searchParameter: searchParameter));
//                       },
//                       leading: const Icon(
//                         Icons.search,
//                         color: PurpleTheme.LightPurpleColor,
//                       ),
//                     );
//                   }, suggestionsBuilder:
//                       (BuildContext context, SearchController controller) {
//                     return [
//                       SizedBox.shrink()
//                     ]; // This will ensure no suggestion bar is shown
//                   }),
//                 ),