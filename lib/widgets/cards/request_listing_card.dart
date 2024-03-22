import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nsutbazaar/constants/darkTheme.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/extensions/strings.dart';
import 'package:nsutbazaar/models/RequestProductModel.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestListCard extends StatelessWidget {
  final RequestProductModel requestProductModel;

  const RequestListCard({Key? key, required this.requestProductModel})
      : super(key: key);

  void launchWhatsApp(String phone) async {
    // Convert the URL string to a Uri object
    try {
      String url = 'whatsapp://send?phone=$phone';
      Uri uri = Uri.parse(url);
      launchUrl(uri);
    } catch (e) {
      print(e);
      try {
        String url = 'whatsapp://send?phone=+$phone';
        Uri uri = Uri.parse(url);
        launchUrl(uri);
      } catch (e) {
        print(e);
        try {
          String url = 'whatsapp://send?phone=+91$phone';
          Uri uri = Uri.parse(url);
          launchUrl(uri);
        } catch (e) {
          print(e);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 323.w,
      height: 99.h,
      decoration: BoxDecoration(
        color: Color.fromARGB(0, 255, 0, 0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12.0.r, // Radius of the circular avatar
                    backgroundColor: Colors.blue, // Example background color
                  ),
                  SizedBox(width: 8.0), // Add spacing between avatar and text
                  Text(
                    'Anonymous',
                    style: TextStyle(
                      fontSize: 12.0.sp, // Font size of the text
                      fontWeight: FontWeight.bold, // Bold text
                      color: Colors.white, // Text color
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          launchWhatsApp(requestProductModel.contact.toString());
                        },
                        child: SizedBox(
                          width: 22.w, // Width based on screen width
                          height: 22.h, // Height based on screen height
                          child: SvgPicture.asset('assets/whatsapp.svg'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              width: 313.w,
              height: 62.h,
              decoration: BoxDecoration(
                color: DarkTheme.dtSkeleton, // Gray color for the container
                borderRadius:
                    BorderRadius.circular(8.r), // Rounded corners with radius 8
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          requestProductModel.productName.toTitleCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '₹${requestProductModel.price.toString()}',
                          style: TextStyle(
                              color: PurpleTheme.LightPurpleColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5.h, 0, 0),
                      child: SizedBox(
                        height: 20.h,
                        width: 292.w,
                        child: Text(
                          requestProductModel.description.toCapitalized(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 10.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
