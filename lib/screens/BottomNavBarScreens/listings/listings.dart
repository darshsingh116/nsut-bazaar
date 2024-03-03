// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:nsutbazaar/widgets/cards/sell_listing_card.dart';
import 'package:nsutbazaar/widgets/cards/sell_listing_card_horizontal.dart';

class ListingsScreen extends StatefulWidget {
  const ListingsScreen({Key? key}) : super(key: key);

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  @override
  Widget build(BuildContext context) {
    final listingsBloc = context.read<ListingsBloc>();
    final firebaseRepository = context.read<FirebaseRepository>();
    final localData = context.read<LocalData>();
    double containerWidth = 175.w;
    double containerHeight = 280.h;

    return BlocConsumer<ListingsBloc, ListingsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ListingsStateInitial) {
          listingsBloc.add(
              ListingsEventGetAllList(firebaseRepository: firebaseRepository));
        }
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                //SizedBox(height: 30),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.sp, horizontal: 30.sp),
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
                Container(
                  height: 58.h,
                  child: Expanded(
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
                ),

                BlocBuilder<ListingsBloc, ListingsState>(
                  builder: (context, state) {
                    if (state is ListingsStateLoading ||
                        state is ListingsStateInitial) {
                      return CircularProgressIndicator();
                    } else if (state is ListingsStateGotList) {
                      if (state.productList.isEmpty) {
                        return Text('No products available');
                      } else {
                        return Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.fromLTRB(10.sp, 10.sp, 10.sp, 0),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio:
                                    containerWidth / containerHeight,
                                crossAxisSpacing: 10.0.w,
                                mainAxisSpacing: 0.0,
                              ),
                              itemCount: state.productList.length,
                              itemBuilder: (context, index) {
                                SellProductModel product =
                                    state.productList[index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetails(
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

class TagButtons extends StatefulWidget {
  String title;
  bool isSelected;
  TagButtons({
    Key? key,
    required this.title,
    required this.isSelected,
  }) : super(key: key);
  @override
  State<TagButtons> createState() => _TagButtonsState();
}

class _TagButtonsState extends State<TagButtons> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onDoubleTap: () {
          //ontap here
        },
        child: Container(
          height: 32.0,
          // Adjust this according to your text size
          decoration: BoxDecoration(
            color: widget.isSelected
                ? PurpleTheme.LightPurpleColor
                : PurpleTheme.PurpleColor,
            borderRadius: BorderRadius.circular(16.0.r),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final List<Widget> tagButtonsList = [
  TagButtons(
    title: "All",
    isSelected: true,
  ),
  TagButtons(
    title: "Books",
    isSelected: false,
  ),
  TagButtons(
    title: "Sports",
    isSelected: false,
  ),
  TagButtons(
    title: "Academic tools",
    isSelected: false,
  ),
  TagButtons(
    title: "Others",
    isSelected: false,
  ),
];
