import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/BottomNavBar.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_event.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_state.dart';
import 'package:nsutbazaar/screens/DrawerScreens/my_listings.dart';
import 'package:nsutbazaar/screens/DrawerScreens/my_requests.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Drawer AppBarDrawer(
  BuildContext context,
) {
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the drawer if there isn't enough vertical
  // space to fit everything.
  return Drawer(
    backgroundColor: PurpleTheme.DarkPurpleNavbarColor,
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 300.h,
          child: DrawerHeader(
            decoration: BoxDecoration(),
            child: Column(
              children: [
                // Image.asset(
                //   'assets/black_logo.jpeg', // Replace with the path to your image asset
                //   height: 150,
                //   width: 150,
                //   fit: BoxFit.fill, // Adjust the height as needed
                // ),
                SizedBox(
                  height: 20.h,
                ),
                SvgPicture.asset(
                  'assets/nsut_bazaar_logo_no_bg.svg',
                  semanticsLabel: 'An SVG image',
                  height: 100.h,
                ),
                Text(
                  'NSUT Bazaar',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Contact Us : uwu@gmail.com',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: Container(
            child: ListTile(
              title: Text(
                'Home',
                style: TextStyle(color: Colors.white, fontSize: 17.sp),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => NavBarScreens()));
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: Container(
            child: ListTile(
              title: Text(
                'My Listings',
                style: TextStyle(color: Colors.white, fontSize: 17.sp),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyListings()),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: Container(
            child: ListTile(
              title: Text(
                'My Requests',
                style: TextStyle(color: Colors.white, fontSize: 17.sp),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyRequests()),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: Container(
            child: ListTile(
              title: Text(
                'Shops',
                style: TextStyle(color: Colors.white, fontSize: 17.sp),
              ),
              onTap: () {
                // Update the state of the app
                //_onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: Container(
            child: ListTile(
              title: Text(
                'About Us',
                style: TextStyle(color: Colors.white, fontSize: 17.sp),
              ),
              onTap: () {
                // Update the state of the app
                //_onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: Container(
            child: ListTile(
              title: Text(
                'Report Bug',
                style: TextStyle(color: Colors.white, fontSize: 17.sp),
              ),
              onTap: () {
                // Update the state of the app
                //_onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    ),
  );
}
