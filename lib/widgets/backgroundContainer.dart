import 'package:flutter/material.dart';
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
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 80, 80, 80),
              Color.fromARGB(255, 0, 0, 0)
            ], // Adjust the colors as needed
            //begin: Alignment(0.05, 0.05),
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        );
  }
}
