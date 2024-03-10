import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/extensions/strings.dart';
import 'package:nsutbazaar/models/RequestProductModel.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestListCard extends StatelessWidget {
  final RequestProductModel requestProductModel;

  const RequestListCard({Key? key, required this.requestProductModel})
      : super(key: key);


  void launchWhatsApp(String phone) async {// Convert the URL string to a Uri object
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
      width: 390.w,
      height: 110.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 48.h,
              width: 48.w,
              decoration: BoxDecoration(
                color: PurpleTheme.PurpleColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.sports_football,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            SizedBox(
              width: 250.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    requestProductModel.productName.toTitleCase(),
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                  Text(
                    'Budget: ₹${requestProductModel.price.toString()}',
                    style: TextStyle(
                        color: PurpleTheme.LightPurpleColor, fontSize: 14.sp),
                  ),
                  Text(
                    requestProductModel.description.toCapitalized(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: PurpleTheme.LightPurpleColor, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                launchWhatsApp(requestProductModel.contact.toString());
              },
              child: Icon(
                Icons.sms,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
