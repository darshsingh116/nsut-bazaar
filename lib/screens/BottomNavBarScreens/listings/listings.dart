// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/models/SellProductModel.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/repositories/local_data.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_event.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_state.dart';
import 'package:nsutbazaar/screens/Product/product_details.dart';
import 'package:nsutbazaar/widgets/cards/latest_post_card.dart';
import 'package:nsutbazaar/widgets/cards/sell_listing_card.dart';
import 'package:nsutbazaar/widgets/tagButton.dart';

class ListingsScreen extends StatefulWidget {
  const ListingsScreen({Key? key}) : super(key: key);

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  late ScrollController _parentScrollController;
  late ScrollController _childScrollController;

  bool _isParentScrollingEnabled = true;
  bool _isChildScrollingEnabled = false;

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
    _childScrollController = ScrollController();
    _parentScrollController.addListener(_onParentScroll);
    _childScrollController.addListener(_onChildScroll);
  }

  @override
  void dispose() {
    _parentScrollController.dispose();
    _childScrollController.dispose();
    super.dispose();
  }

  void _onParentScroll() {
    print(
        "_parentScrollController.offset:${_parentScrollController.offset} ,_parentScrollController.position.maxScrollExtent : ${_parentScrollController.position.maxScrollExtent}");
    print(
        "_childScrollController.position.pixels:${_childScrollController.position.pixels} , _childScrollController.position.minScrollExtent : ${_childScrollController.position.minScrollExtent}");
    if (_parentScrollController.offset >=
        _parentScrollController.position.maxScrollExtent) {
      setState(() {
        //_isParentScrollingEnabled = false;
        _isChildScrollingEnabled = true;
      });
    }
  }

  void _onChildScroll() {
    print(
        "_childScrollController.position.pixels:${_childScrollController.position.pixels} , _childScrollController.position.minScrollExtent : ${_childScrollController.position.minScrollExtent}");
    print(_childScrollController.position.userScrollDirection);
    if (_childScrollController.position.pixels <=
        _childScrollController.position.minScrollExtent) {
      setState(() {
        _isParentScrollingEnabled = true;
        _isChildScrollingEnabled = false;
      });
    }
  }

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
          listingsBloc.add(ListingsEventGetAllList(
              firebaseRepository: firebaseRepository, localData: localData));
        }
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                //SizedBox(height: 30),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 30.w),
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
                  child: SingleChildScrollView(
                    physics: _isParentScrollingEnabled
                        ? AlwaysScrollableScrollPhysics()
                        : NeverScrollableScrollPhysics(),
                    // this is parent
                    controller: _parentScrollController,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 840.h,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 10.w),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "Latest Post :",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Container(
                                  height: 180.h,
                                  child:
                                      BlocBuilder<ListingsBloc, ListingsState>(
                                    builder: (context, state) {
                                      if (state is ListingsStateLoading ||
                                          state is ListingsStateInitial) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (state
                                              is ListingsStateGotList ||
                                          state
                                              is ListingsStateGotSearchedList) {
                                        if (state is ListingsStateGotList) {
                                          LatestPostList = state.productList;
                                        }
                                        if (LatestPostList.isEmpty) {
                                          return Center(
                                            child: Text(
                                              'No products available',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        } else {
                                          return SizedBox(
                                            // Adjust the height as per your requirement
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  (LatestPostList.length <= 5)
                                                      ? LatestPostList.length
                                                      : 5,
                                              itemBuilder: (context, index) {
                                                SellProductModel product =
                                                    LatestPostList[index];

                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductDetails(
                                                            product: product,
                                                            localData:
                                                                localData,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: LatestPostCards(
                                                      sellProductModel: product,
                                                    ),
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
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(
                              //       vertical: 10.h, horizontal: 10.w),
                              //   child: SizedBox(
                              //     width: double.infinity,
                              //     child: Text(
                              //       "All Post :",
                              //       style: TextStyle(
                              //         fontSize: 22.sp,
                              //         fontWeight: FontWeight.bold,
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                height: 58.h,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: tagButtonsList
                                        .length, // Adjust this according to your data
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10.w, 0, 0, 0),
                                        child: tagButtonsList[index],
                                      );
                                    }),
                              ),
                              BlocBuilder<ListingsBloc, ListingsState>(
                                builder: (context, state) {
                                  if (state is ListingsStateLoading ||
                                      state is ListingsStateInitial) {
                                    return CircularProgressIndicator();
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
                                      return Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10.w, 10.h, 10.w, 0),
                                          child: GridView.builder(
                                            controller: _childScrollController,
                                            physics: _isChildScrollingEnabled
                                                ? AlwaysScrollableScrollPhysics()
                                                : NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: containerWidth /
                                                  containerHeight,
                                              crossAxisSpacing: 10.0.w,
                                              mainAxisSpacing: 0.0,
                                            ),
                                            itemCount: list.length,
                                            itemBuilder: (context, index) {
                                              SellProductModel product =
                                                  list[index];

                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetails(
                                                              product: product,
                                                              localData:
                                                                  localData,
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
                                        ),
                                      );
                                    }
                                  }
                                  return Text("Error Out of States");
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
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



//height: MediaQuery.of(context).size.height *1.1,