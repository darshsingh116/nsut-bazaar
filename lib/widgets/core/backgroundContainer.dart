import 'package:flutter/material.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
class backgroundContainer extends StatelessWidget {
  final Widget child;
  const backgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
          child:Container(
                      child: child,
                      decoration: BoxDecoration(color: Colors.transparent),
                    ),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: PurpleTheme.DarkPurpleBackgroundColor
              ),
        );
  }
}
