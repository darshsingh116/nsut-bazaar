import 'package:flutter/material.dart';
class backgroundContainer extends StatelessWidget {
  final Widget child;
  const backgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
        ),
        // Container(
        //   height: MediaQuery.of(context).size.height * 0.3,
        //   decoration: BoxDecoration(color: Color.fromARGB(77, 255, 255, 255)),
        // ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.015,
              color: Color.fromARGB(255, 206, 255, 68),
            ),
            Expanded(
              child: Container(
                      child: child,
                      decoration: BoxDecoration(color: Colors.transparent),
                    ),
            )
          ],
        ),
        
      ],
    );
  }
}
