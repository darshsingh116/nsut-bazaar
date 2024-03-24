import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZoomedImage extends StatelessWidget {
  final AssetImage assetImage;

  const ZoomedImage({
    Key? key,
    required this.assetImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         Navigator.pop(context);
      },
      child: Container(
        color: const Color.fromARGB(255, 50, 50, 50),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200.r),
            child: Image(
              image: assetImage,
              fit: BoxFit.cover,
              width: 400.w,
              height: 300.h,
            ),
          ),
        ),
      ),
    );
  }
}
