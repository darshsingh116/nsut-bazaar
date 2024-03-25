import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nsutbazaar/constants/darkTheme.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/models/RequestProductModel.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/requests/bloc/requests_bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/requests/bloc/requests_event.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/requests/bloc/requests_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsutbazaar/screens/Product/request_details.dart';
import 'package:nsutbazaar/widgets/cards/request_listing_card.dart';
import 'package:nsutbazaar/widgets/cards/request_listing_card_skeleton_loading.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({Key? key}) : super(key: key);

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  @override
  Widget build(BuildContext context) {
    final requestsBloc = context.read<RequestsBloc>();
    final firebaseRepository = context.read<FirebaseRepository>();

    return BlocConsumer<RequestsBloc, RequestsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is RequestsStateInitial) {
          requestsBloc.add(
              RequestsEventGetAllList(firebaseRepository: firebaseRepository));
        }
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.sp, horizontal: 30.sp),
                  child: SearchAnchor(builder:
                      (BuildContext context, SearchController controller) {
                    return SearchBar(
                      backgroundColor:
                          MaterialStateProperty.all(DarkTheme.dtSearchBar),
                      hintText: "Search",
                      hintStyle: MaterialStateProperty.all(
                          TextStyle(color: PurpleTheme.LightPurpleColor)),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(color: Colors.white)),
                      controller: controller,
                      padding: MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0.sp)),
                      onChanged: (searchParameter) {
                        requestsBloc.add(RequestsEventGetSearchedList(
                            firebaseRepository: firebaseRepository,
                            searchParameter: searchParameter));
                      },
                      onSubmitted: (searchParameter) {
                        requestsBloc.add(RequestsEventGetSearchedList(
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
                // SizedBox(
                //   height: 5.h,
                // ),
                // Padding(
                //             padding: EdgeInsets.symmetric(horizontal: 15.w),
                //             child: Text(
                //               "Requests",
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 15.sp,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //           ),
                SizedBox(
                  height: 10.h,
                ),
                BlocBuilder<RequestsBloc, RequestsState>(
                  builder: (context, state) {
                    if (state is RequestsStateLoading ||
                        state is RequestsStateInitial) {
                      return Expanded(
                        child: ListView(
                          children: [
                            RequestListCardSkeletonLoading(),
                            RequestListCardSkeletonLoading(),
                            RequestListCardSkeletonLoading(),
                            RequestListCardSkeletonLoading(),
                            RequestListCardSkeletonLoading(),
                            RequestListCardSkeletonLoading(),
                            RequestListCardSkeletonLoading(),
                            RequestListCardSkeletonLoading(),
                            RequestListCardSkeletonLoading(),
                            RequestListCardSkeletonLoading(),
                            RequestListCardSkeletonLoading(),
                            RequestListCardSkeletonLoading(),
                            RequestListCardSkeletonLoading(),
                          ],
                        ),
                      );
                    } else if (state is RequestsStateGotList) {
                      if (state.productList.isEmpty) {
                        return Text('No products available');
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.productList.length,
                            itemBuilder: (context, index) {
                              RequestProductModel product =
                                  state.productList[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: RequestListCard(
                                    requestProductModel: product),
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
        );
      },
    );
  }
}
