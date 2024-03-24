import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import 'package:nsutbazaar/constants/darkTheme.dart';
import 'package:nsutbazaar/screens/DrawerScreens/add_listing.dart';
import 'package:nsutbazaar/screens/DrawerScreens/add_request.dart';

class AddDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        child: _dialogContent(context),
      ),
    );
  }

  Widget _dialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              // Handle Add Listing button press
              Navigator.pop(context); // Close the dialog
              // Add your logic for Add Listing here
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddListingScreen()));
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              backgroundColor: DarkTheme.dtDarkPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r), // Rounded corner radius
              ),
            ),
            child: Text("Add Listing", style: GoogleFonts.saira(fontSize: 15.sp, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: () {
              // Handle Add Request button press
              Navigator.pop(context); // Close the dialog
              // Add your logic for Add Request here
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddRequestScreen()));
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              backgroundColor: DarkTheme.dtDarkPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r), // Rounded corner radius
              ),
            ),
            child: Text("Add Request", style: GoogleFonts.saira(fontSize: 15.sp, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
