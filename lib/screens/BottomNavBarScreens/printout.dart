import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
              SvgPicture.asset(
                'assets/login.svg',
                semanticsLabel: 'An SVG image',
                height: 230.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Coming Soon!",
                style: TextStyle(
                    color: Color.fromARGB(255, 192, 91, 255), fontSize: 20.sp),
              ),
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
