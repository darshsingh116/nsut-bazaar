import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';

class PrintOutScreen extends StatefulWidget {
  const PrintOutScreen({Key? key}) : super(key: key);

  @override
  _PrintOutScreenState createState() => _PrintOutScreenState();
}

class _PrintOutScreenState extends State<PrintOutScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.fromLTRB(15.w, 0, 0, 0),
                child: Image.asset(
                  'assets/purple_tea.png', // Change the path as per your asset location
                  width: 150.w,
                  height: 150.h,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Coming Soon!",
                style: TextStyle(
                    color: Color.fromARGB(255, 192, 91, 255), fontSize: 15.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
