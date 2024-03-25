import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nsutbazaar/constants/darkTheme.dart';
import 'package:nsutbazaar/models/TagItem.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/home/home_page.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/listings.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/plusPageView.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/profile_page.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/requests/requests.dart';
import 'package:nsutbazaar/screens/DrawerScreens/add_listing.dart';
import 'package:nsutbazaar/widgets/addDialog.dart';
import 'package:nsutbazaar/widgets/core/backgroundContainer.dart';
import 'package:nsutbazaar/widgets/core/nsutbazaar_appBar.dart';

class NavBarScreens extends StatefulWidget {
  const NavBarScreens({Key? key}) : super(key: key);

  @override
  State<NavBarScreens> createState() => _NavBarScreensState();
}

class _NavBarScreensState extends State<NavBarScreens> {
  int _selectedIndex = 0;

  static List<Widget> _screensList = [
    HomePage(),
    ListingsScreen(),
    RequestsScreen(),
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
        extendBodyBehindAppBar: true,
        appBar: nsutbazaarAppBar(context,_selectedIndex),
        backgroundColor: Colors.transparent,
        body: IndexedStack(
          index: _selectedIndex,
          children: _screensList,
        ),
  //       floatingActionButton: SizedBox(
  //         width: 50.w, // Increased width of the container
  // height: 50.h,
  //         child: FloatingActionButton(
            
  //           onPressed: () {
  //             // Handle FAB tap
  //           },
  //           child: Icon(Icons.add,color: DarkTheme.dtDarkPurple,size: 30.sp,),
  //           backgroundColor: Color.fromARGB(255, 0, 0, 0), // Change FAB background color
  //         ),
  //       ),
  //       //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: DarkTheme.dtBackgroundColor,
          //shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Added space around icons
              children: <Widget>[
                IconButton(
                  splashRadius: 20.r,
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    Icons.home_filled,
                    size: 25.sp,
                    color: _selectedIndex == 0 ? DarkTheme.dtDarkPurple: Colors.grey,
                  ),
                  onPressed: () {
                    _onItemTapped(0);
                  },
                ),
                IconButton(
                  splashRadius: 20.r,
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    Icons.feed_outlined,
                    size: 25.sp,
                    color: _selectedIndex == 1 ? DarkTheme.dtDarkPurple: Colors.grey,
                  ),
                  onPressed: () {
                    _onItemTapped(1);
                  },
                ),
                IconButton(
                  splashRadius: 20.r,
                  highlightColor: Colors.transparent,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10.h),
                  icon: Icon(
                    Icons.add_circle_rounded,
                    size: 40.sp,
                  
                    color: DarkTheme.dtLightPurple,
                  ),
                  onPressed: () {
                    showDialog(
      context: context,
      builder: (context) => AddDialog(),
    );
        //             Navigator.push(
        // context,
        // MaterialPageRoute(builder: (context) => MyPageView()));
      
                  },
                ),
                //SizedBox(width: 20.w), // Added space from the edge of icons
                IconButton(
                  splashRadius: 20.r,
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    Icons.insert_comment,
                    size: 25.sp,
                    color: _selectedIndex == 2 ? DarkTheme.dtDarkPurple: Colors.grey,
                  ),
                  onPressed: () {
                    _onItemTapped(2);
                  },
                ),
                IconButton(
                  splashRadius: 20.r,
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    Icons.person,
                    size: 25.sp,
                    color: _selectedIndex == 3 ? DarkTheme.dtDarkPurple: Colors.grey,
                  ),
                  onPressed: () {
                    _onItemTapped(3);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
