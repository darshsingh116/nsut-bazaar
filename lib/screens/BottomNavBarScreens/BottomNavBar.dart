import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart'; // Import the google_nav_bar package
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
  int _selectedIndex = 1;

  static List<Widget> _screensList = [
    //FeedbackScreen(),
    RequestsScreen(),
    ListingsScreen(),
    PrintOutScreen(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return backgroundContainer(
      child: Scaffold(
        drawer: AppBarDrawer(context),
        extendBodyBehindAppBar: true,
        appBar: nsutbazaarAppBar(NavBarItems[_selectedIndex], context),
        backgroundColor: Colors.transparent,
        body: IndexedStack(
          index: _selectedIndex,
          children: _screensList,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Color.fromARGB(135, 40, 21, 51)),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.h),
              child: GNav(
                rippleColor: const Color.fromARGB(102, 224, 224, 224),
                hoverColor: Colors.grey,
                gap: 3, // Gap between icon and text
                activeColor: Colors.white, // Selected item color
                iconSize: 24.sp, // Icon size
                tabBackgroundColor: PurpleTheme.LightPurpleColor,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                tabs: getBottomTabs(NavBarItems),
                selectedIndex: _selectedIndex,
                onTabChange: _onItemTapped,
                color: PurpleTheme.LightPurpleColor,
                duration: Duration(milliseconds: 350)
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<MyTabItem> NavBarItems = [
  //MyTabItem('Feedback', 'Feedback Screen', Icons.feedback, false),
  MyTabItem('Requests', 'Requests', Icons.insert_comment, false),
  MyTabItem('Listings', 'Listings', Icons.feed_outlined, false),
  MyTabItem('Print Out', 'PrintOut', Icons.print_outlined, false),
  MyTabItem('Profile', 'Profile', Icons.person, true),
];

List<GButton> getBottomTabs(List<MyTabItem> items) {
  return items.map((e) {
    return GButton(
      icon: e.icon,
      text: e.title,
    );
  }).toList();
}
