import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nsutbazaar/constants/darkTheme.dart';

class ImageDialog extends StatelessWidget {
  final AssetImage assetImage;

  const ImageDialog({Key? key, required this.assetImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        child: _dialogContent(),
      ),
    );
  }

  Widget _dialogContent() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 100.w, // Adjust the radius as needed
            backgroundImage: assetImage,
          ),          
        ],
      ),
    );
  }
}
