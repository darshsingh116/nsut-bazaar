import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/repositories/firebase_storage_repo.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/dashboard.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/profile_page.dart';
import 'package:nsutbazaar/widgets/backgroundContainer.dart';
import 'package:nsutbazaar/widgets/hackethix_appBar.dart';
import 'package:nsutbazaar/widgets/app_bar_drawer.dart';

class NavBarScreens extends StatefulWidget {
  const NavBarScreens({super.key});

  @override
  State<NavBarScreens> createState() => _NavBarScreensState();
}

class _NavBarScreensState extends State<NavBarScreens> {
  @override
  // ignore: must_call_super
  initState() {;
    super.initState();
  }

  int index = 0;
  List<Widget> screensList = [Dashboard()];

  @override
  Widget build(BuildContext context) {
    return backgroundContainer(
      child: Scaffold(
        drawer: AppBarDrawer(context),
        extendBodyBehindAppBar: true,
        appBar: hackethixAppBar(NavBarItems[index].title, context),
        backgroundColor: Colors.transparent,
        body: screensList[index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          elevation: 0,
          backgroundColor: const Color.fromARGB(
              255, 29, 29, 37), // Dark blue background color
          type: BottomNavigationBarType.shifting,
          selectedIconTheme: IconThemeData(
              color: Color.fromARGB(
                  255, 205, 255, 68)), // Set the color for selected icons
          unselectedIconTheme:
              IconThemeData(color: Color.fromARGB(255, 84,83,84)),
          selectedItemColor: Color.fromARGB(255, 205, 255,
              68), // Set the color for selected items (icons and text)
          unselectedItemColor: Color.fromARGB(255, 84,83,84), // Set the color for unselected items (icons and text)
          iconSize: 30, // Set the size of the icons
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

class MyTabItem {
  String appBarTitle;
  String title;
  IconData icon;
  MyTabItem(
    this.appBarTitle,
    this.title,
    this.icon,
  );
}

List<MyTabItem> NavBarItems = [
  MyTabItem('Events Screen', 'Events', Icons.calendar_month_outlined),
  MyTabItem('Practice Screen', 'Practice', Icons.question_answer_outlined),
  
  MyTabItem('Dashboard Screen', 'Dashboard', Icons.speed_outlined),
  MyTabItem('Resources Screen', 'Resources', Icons.menu_book_outlined),
  
  MyTabItem('Profile Screen', 'Profile', Icons.person),
];

List<BottomNavigationBarItem> getBottomTabs(List<MyTabItem> items) {
  return items.map((e) {
    return BottomNavigationBarItem(
        icon: Icon(e.icon),
        label: e.title,
        backgroundColor: Colors.transparent);
  }).toList();
}

int _selectedIndex = 0;
TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
