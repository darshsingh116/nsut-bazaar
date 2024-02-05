import 'package:flutter/material.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/BottomNavBar.dart';

Drawer AppBarDrawer(
  BuildContext context,
) {
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the drawer if there isn't enough vertical
  // space to fit everything.
  return Drawer(
    backgroundColor: Color.fromARGB(255, 206, 255, 68),
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 300,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 74, 74, 74),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/black_logo.jpeg', // Replace with the path to your image asset
                  height: 150,
                  width: 150,
                  fit: BoxFit.fill, // Adjust the height as needed
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'HackethiX.NSUT',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text('Contact Us : hackethix.nsut@gmail.com'),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Container(
            color: Color.fromARGB(255, 74, 74, 74),
            child: ListTile(
              title: const Text(
                'Home',
                style: TextStyle(
                    color: Color.fromARGB(255, 238, 238, 238), fontSize: 17),
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
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Container(
            color: Color.fromARGB(255, 74, 74, 74),
            child: ListTile(
              title: const Text(
                'Gallery',
                style: TextStyle(
                    color: Color.fromARGB(255, 238, 238, 238), fontSize: 17),
              ),
              onTap: () {
                Navigator.pop(context);
                
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Container(
            color: Color.fromARGB(255, 74, 74, 74),
            child: ListTile(
              title: const Text(
                'Core Members',
                style: TextStyle(
                    color: Color.fromARGB(255, 238, 238, 238), fontSize: 17),
              ),
              onTap: () {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Container(
            color: Color.fromARGB(255, 74, 74, 74),
            child: ListTile(
              title: const Text(
                'Developers',
                style: TextStyle(
                    color: Color.fromARGB(255, 238, 238, 238), fontSize: 17),
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
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Container(
            color: Color.fromARGB(255, 74, 74, 74),
            child: ListTile(
              title: const Text(
                'About Us',
                style: TextStyle(
                    color: Color.fromARGB(255, 238, 238, 238), fontSize: 17),
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
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Container(
            color: Color.fromARGB(255, 74, 74, 74),
            child: ListTile(
              title: const Text(
                'Report Bug',
                style: TextStyle(
                    color: Color.fromARGB(255, 238, 238, 238), fontSize: 17),
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
