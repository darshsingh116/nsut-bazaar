import 'dart:ui';

import 'package:flutter/material.dart';

PreferredSize hackethixAppBar(String title, BuildContext context) {
  Future<void> InfoDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('HackethiX App Info'),
          content: const Text(
            'This app belongs to HackethiX.NSUT society.\n'
            'For more info contact tech.hackethix.nsut@gmail.com\n',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  return PreferredSize(
    preferredSize: Size.fromHeight(50.0),
    child: AppBar(
      iconTheme:
          IconThemeData(color: Color.fromARGB(255, 206, 255, 68), size: 30),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft:
            Radius.circular(0), // Adjust the radius to control corner shape
        bottomRight: Radius.circular(0),
      )),
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 74, 74, 74),
      elevation: 0,
      // leading: GestureDetector(
      //   child: Icon(Icons.menu,color: Color.fromARGB(255, 206, 255, 68), size: 30),
      //   onTap: () {},
      //),
      // title: Text(
      //   title,
      //   style: TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 20 // Text color
      //       ),
      // ),
      actions: <Widget>[
        GestureDetector(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Icon(
                Icons.info,
              ),
            ),
            onTap: () => InfoDialog(context)),
      ],
    ),
  );
}


// return PreferredSize(
//     preferredSize: Size.fromHeight(50.0),
//     child: ClipRect(
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//         child: AppBar(
//           centerTitle: true,
//           backgroundColor: Colors.transparent,
          
          
//           elevation: 0,
//           leading: GestureDetector(
//             child: Icon(Icons.info),
//             onTap: () => InfoDialog(context),
//           ),
//           // title: Text(
//           //   title,
//           //   style: TextStyle(
//           //       color: Colors.white,
//           //       fontWeight: FontWeight.bold,
//           //       fontSize: 20 // Text color
//           //       ),
//           // ),
//           actions: <Widget>[
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//               child: Icon(Icons.info,
//                   color: Color.fromARGB(255, 206, 255, 68), size: 30),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
