import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/screens/Product/liked_sell_products.dart';

PreferredSize secondaryAppBar(String title, BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
    child: AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 30),
      ),
      iconTheme: IconThemeData(color: Colors.yellow, size: 30),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft:
            Radius.circular(0), // Adjust the radius to control corner shape
        bottomRight: Radius.circular(0),
      )),
      toolbarHeight: MediaQuery.of(context).size.height * 0.07,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}
