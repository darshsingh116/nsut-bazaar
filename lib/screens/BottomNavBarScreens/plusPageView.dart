import 'package:flutter/material.dart';
import 'package:nsutbazaar/constants/darkTheme.dart';
import 'package:nsutbazaar/screens/DrawerScreens/add_listing.dart';
import 'package:nsutbazaar/screens/DrawerScreens/add_request.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: DarkTheme.dtBackgroundColor,
          elevation: 0,
          title: Text("Add "),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home_filled),
                text: "Listing",
              ),
              Tab(
                icon: Icon(Icons.account_box_outlined),
                text: "Request",
              ),              
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AddListingScreen(),
            //AddRequestScreen()
          ],
        ),
      ),
    );
  }
}
