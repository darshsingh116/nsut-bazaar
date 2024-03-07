// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/models/TagItem.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/feedback.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/listings.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/printout.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/profile_page.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/requests/requests.dart';
import 'package:nsutbazaar/widgets/core/app_bar_drawer.dart';
import 'package:nsutbazaar/widgets/core/backgroundContainer.dart';
import 'package:nsutbazaar/widgets/core/nsutbazaar_appBar.dart';

class NavBarScreens extends StatefulWidget {
  const NavBarScreens({super.key});

  @override
  State<NavBarScreens> createState() => _NavBarScreensState();
}

class _NavBarScreensState extends State<NavBarScreens> {
  @override
  // ignore: must_call_super
  initState() {
    super.initState();
  }

  int index = 2;
  List<Widget> screensList = [
    FeedbackScreen(),
    RequestsScreen(),
    ListingsScreen(),
    PrintOutScreen(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return backgroundContainer(
      child: Scaffold(
        drawer: AppBarDrawer(context),
        extendBodyBehindAppBar: true,
        appBar: nsutbazaarAppBar(NavBarItems[index], context),
        backgroundColor: Colors.transparent,
        body: screensList[index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          elevation: 0,
          showUnselectedLabels: true,
          backgroundColor:
              Color.fromARGB(135, 40, 21, 51), // Dark blue background color
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: IconThemeData(
              color: Colors.white,
              size: 24.sp), // Set the color for selected icons
          unselectedIconTheme:
              IconThemeData(color: PurpleTheme.LightPurpleColor, size: 20.sp),
          selectedItemColor:
              Colors.white, // Set the color for selected items (icons and text)
          unselectedItemColor: PurpleTheme.LightPurpleColor,
          unselectedLabelStyle: TextStyle(fontSize: 10.sp),

          selectedLabelStyle: TextStyle(
              fontSize:
                  12.sp), // Set the color for unselected items (icons and text)

          // Set the size of the icons
          items: getBottomTabs(NavBarItems),
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
        ),
      ),
    );
  }
}

List<MyTabItem> NavBarItems = [
  MyTabItem('Feedback Screen', 'Feedback', Icons.feedback, false),
  MyTabItem('Requests Screen', 'Requests', Icons.insert_comment, false),
  MyTabItem('Listings Screen', 'Discover', Icons.feed_outlined, false),
  MyTabItem('PrintOut Screen', 'Print Out', Icons.print_outlined, false),
  MyTabItem('Profile Screen', 'Profile', Icons.person, true),
];

List<BottomNavigationBarItem> getBottomTabs(List<MyTabItem> items) {
  return items.map((e) {
    return BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Icon(
            e.icon,
          ),
        ),
        label: e.title,
        backgroundColor: Color.fromARGB(135, 40, 21, 51));
  }).toList();
}
