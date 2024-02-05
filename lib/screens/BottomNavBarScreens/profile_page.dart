import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsutbazaar/auth/bloc/auth_bloc.dart';
import 'package:nsutbazaar/auth/bloc/auth_event.dart';
import 'package:nsutbazaar/auth/bloc/auth_state.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/auth/login.dart';
import 'package:nsutbazaar/widgets/backgroundContainer.dart';
import 'package:nsutbazaar/widgets/hackethix_appBar.dart';
import 'dart:ui';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void updateProfile() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<FirebaseRepository>();
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoggedOut) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width *
                        0.3, // Adjust the width as needed
                    height: MediaQuery.of(context).size.width *
                        0.3, // Adjust the height as needed
                    margin: EdgeInsets.all(2), // Add a margin for the gap
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color.fromARGB(255, 206, 255, 68),
                        width: 1, // Adjust the border width as needed
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/paimon.jpeg', // Replace with your image URL
                          fit: BoxFit.cover, // Adjust the fit as needed
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      authRepository.userModel.username,
                      style: TextStyle(
                          color: Color.fromARGB(255, 206, 255, 68),
                          fontSize: 32),
                    ),
                  ),
                ),
                Container(
                  //height: MediaQuery.of(context).size.height * 0.01,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Level 10",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width * 0.80,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: Text(
                      "uwu",
                      style: TextStyle(
                          color: Color.fromARGB(255, 164, 161, 161),
                          fontSize: 15),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width * 0.80,
                  color: Colors.black,
                ),
                SizedBox(height: 50),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // Equal space between containers
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.38,
                        height: MediaQuery.of(context).size.width * 0.38,
                        color: Color.fromARGB(255, 78, 78, 78),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Daily Streak',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Icon(
                              Icons.whatshot,
                              size: MediaQuery.of(context).size.width *
                                  0.20, // Adjust the size as needed
                              color: true
                                  ? Color.fromARGB(255, 206, 255, 68)
                                  : Color.fromARGB(
                                      255, 98, 98, 98), // Icon color
                            ),
                            Text(
                                "uwu"
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: true
                                        ? Color.fromARGB(255, 206, 255, 68)
                                        : Color.fromARGB(255, 98, 98, 98))),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.38,
                        height: MediaQuery.of(context).size.width * 0.38,
                        color: Color.fromARGB(255, 206, 255, 68),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Days Active',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(
                                "69"
                                    .toString(),
                                style: TextStyle(
                                    color: Color.fromARGB(255, 78, 78, 78),
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.055,
                    child: ElevatedButton(
                      onPressed: () {
                        
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(
                            color: Color.fromARGB(
                                255, 206, 255, 68), // Define the border color
                            width: 1.0, // Define the border width
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(
                              155, 41, 41, 41), // Define the background color
                        ),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: Color.fromARGB(255, 206, 255, 68),
                            fontSize:
                                MediaQuery.of(context).size.height * 0.019),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.055,
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthStateIsLoading) {
                          return CircularProgressIndicator(
                            color: const Color.fromARGB(255, 255, 255, 255),
                          );
                        }
                        return ElevatedButton(
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(LogOut(authRepository));
                          },
                          style: ButtonStyle(
                            side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(
                                color: Color.fromARGB(255, 206, 255,
                                    68), // Define the border color
                                width: 1.0, // Define the border width
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(155, 41, 41,
                                  41), // Define the background color
                            ),
                          ),
                          child: Text('Log Out',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 206, 255, 68),
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.019)),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

        //appBar: hackethixAppBar(),
        // body: Column(
        //   children: <Widget>[
        //     Padding(
        //       padding: const EdgeInsets.all(20),
        //       child: ClipRect(
        //         child: BackdropFilter(
        //           filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        //           child: Container(
        //             //padding: EdgeInsets.all(10),
        //             // decoration: BoxDecoration(
        //             //   color:
        //             //       Color.fromARGB(255, 101, 101, 101).withOpacity(0.5),
        //             //   // gradient: RadialGradient(
        //             //   //   colors: [
        //             //   //     Color.fromARGB(255, 255, 255, 255),
        //             //   //     Color.fromARGB(0, 255, 255, 255),
        //             //   //   ],
        //             //   //   center: Alignment.center,
        //             //   // ),
        //             //   borderRadius: BorderRadius.circular(40.0),
        //             //   // boxShadow: [
        //             //   //   BoxShadow(
        //             //   //     color: Color.fromARGB(213, 255, 255, 255),
        //             //   //     offset: Offset(0, 5),
        //             //   //     blurRadius:
        //             //   //         0.0, // Increased blur radius for a blurry effect
        //             //   //   ),
        //             //   // ],
        //             // ),
        //             child: Stack(
        //               //mainAxisAlignment: MainAxisAlignment.start,
        //               children: <Widget>[
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.end,
        //                   children: [
        //                     Center(
        //                         child: Container(
        //                             width:
        //                                 250, // Adjust the width to fit your text
        //                             height:
        //                                 250, // Adjust the height to fit your text
        //                             child: Padding(
        //                               padding: const EdgeInsets.all(5.0),
        //                               child: GlassmorphicContainer(
        //                                 width:
        //                                     240, // Adjust the width to fit your text
        //                                 height:
        //                                     240, // Adjust the height to fit your text
        //                                 borderRadius:
        //                                     120, // Adjust the radius for round corners
        //                                 border: 2, // Border width
        //                                 linearGradient: LinearGradient(
        //                                   begin: Alignment.topCenter,
        //                                   end: Alignment.bottomLeft,
        //                                   colors: [
        //                                     const Color.fromARGB(255, 1, 1, 1)
        //                                         .withOpacity(0.5),
        //                                     Colors.white.withOpacity(0.5)
        //                                   ],
        //                                 ),

        //                                 borderGradient: LinearGradient(
        //                                   begin: Alignment.topLeft,
        //                                   end: Alignment.bottomRight,
        //                                   colors: [
        //                                     Colors.white.withOpacity(0.3),
        //                                     Colors.white.withOpacity(0.05)
        //                                   ],
        //                                 ),
        //                                 blur:
        //                                     10, // Adjust the blur value for the glassmorphism effect
        //                                 alignment: Alignment.center,
        //                                 child: Center(
        //                                   child: Text(
        //                                     authRepository.userModel.username,
        //                                     textAlign: TextAlign.center,
        //                                     style: TextStyle(
        //                                       fontSize: 30.0,
        //                                       fontWeight: FontWeight.bold,
        //                                       color: Colors.white,
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                             )))
        //                   ],
        //                 ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: [
        //                     Padding(
        //                       padding:
        //                           const EdgeInsets.fromLTRB(0, 100, 0, 0),
        //                       child: Stack(children: [
        //                         Container(
        //                             width: 190.0, // Adjust the size as needed
        //                             height:
        //                                 190.0, // Adjust the size as needed
        //                             decoration: BoxDecoration(
        //                               shape: BoxShape.circle,
        //                               gradient: LinearGradient(
        //                                 begin: Alignment.topLeft,
        //                                 end: Alignment.bottomRight,
        //                                 colors: [
        //                                   myLightPink, // Replace with your gradient start color
        //                                   myLightOrange, // Replace with your gradient end color
        //                                 ], // Replace with your gradient colors
        //                               ),
        //                             )),
        //                         Padding(
        //                           padding: const EdgeInsets.all(5.0),
        //                           child: CircleAvatar(
        //                             radius:
        //                                 90.0, // Adjust the radius to fit the container size
        //                             backgroundImage: AssetImage(
        //                                 'assets/paimon.jpeg'), // Your image
        //                           ),
        //                         ),
        //                       ]),
        //                     ),
        //                   ],
        //                 ),
        //                 // SizedBox(
        //                 //   height: 40,
        //                 // ),

        //                 // SizedBox(
        //                 //   height: 20,
        //                 // ),

        //                 // SizedBox(
        //                 //   height: 40,
        //                 // ),
        //                 // Center(
        //                 //   child: Text(
        //                 //     authRepository.userModel.bio,
        //                 //     textAlign: TextAlign.center,
        //                 //     style: TextStyle(
        //                 //       fontSize: 18.0,
        //                 //       color: Color.fromARGB(181, 120, 188, 156),
        //                 //     ),
        //                 //   ),
        //                 // ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.end,
        //                   children: [
        //                     Padding(
        //                       padding:
        //                           const EdgeInsets.fromLTRB(0, 225, 25, 0),
        //                       child: Column(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         children: [
        //                           GlassmorphicContainer(
        //                             width: 80,
        //                             height: 80,
        //                             borderRadius:
        //                                 40, // Half of the width or height for a perfect circle
        //                             linearGradient: LinearGradient(
        //                               begin: Alignment.centerLeft,
        //                               end: Alignment.centerRight,
        //                               colors: [
        //                                 Color.fromARGB(255, 255, 255, 255)
        //                                     .withOpacity(0.5),
        //                                 Color.fromARGB(255, 39, 39, 39)
        //                                     .withOpacity(0.1)
        //                               ],
        //                             ),
        //                             border: 2,
        //                             borderGradient: LinearGradient(
        //                               begin: Alignment.topLeft,
        //                               end: Alignment.bottomRight,
        //                               colors: [
        //                                 Colors.white.withOpacity(0.3),
        //                                 Colors.white.withOpacity(0.05)
        //                               ],
        //                             ),
        //                             blur: 10,
        //                             alignment: Alignment.center,
        //                             child: Center(
        //                               child: Text(
        //                                 authRepository
        //                                     .userModel.userStat.daysActive
        //                                     .toString(),
        //                                 style: TextStyle(
        //                                   fontSize: 24,
        //                                   fontWeight: FontWeight.bold,
        //                                   color: Color.fromARGB(
        //                                       255, 239, 120, 84),
        //                                 ),
        //                               ),
        //                             ),
        //                           ),

        //                           SizedBox(
        //                               height:
        //                                   8), // Space between the circle and the title
        //                           Text(
        //                             "Days Active",
        //                             style: TextStyle(
        //                               color: Colors.white,
        //                               fontSize: 16,
        //                               fontWeight: FontWeight.bold,
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ],
        //                 ),

        //                 // SizedBox(
        //                 //   height: 20,
        //                 // ),

        //                 // ListTile(
        //                 //   leading: Icon(
        //                 //     Icons.phone,
        //                 //     color: Color.fromARGB(255, 255, 255, 255),
        //                 //   ),
        //                 //   title: Text('+123 456 7890',
        //                 //       style: TextStyle(
        //                 //           color: const Color.fromARGB(
        //                 //               255, 255, 255, 255))),
        //                 // ),
        //                 // ListTile(
        //                 //   leading: Icon(
        //                 //     Icons.location_on,
        //                 //     color: Colors.black,
        //                 //   ),
        //                 //   title: Text('New York, USA',
        //                 //       style: TextStyle(color: Colors.black)),
        //                 // ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     SizedBox(height: 20.0),
        //     Expanded(
        //       child: Container(
        //         // Background color
        //         padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(40),
        //             topRight: Radius.circular(40),
        //           ),
        //           color: Color.fromARGB(255, 48, 51, 58),
        //         ),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             Container(
        //               height: 80,
        //               child: Text(
        //                 authRepository.userModel.bio,
        //                 style: TextStyle(color: Colors.white, fontSize: 20),
        //                 maxLines: 3,
        //                 overflow: TextOverflow.ellipsis,
        //                 textAlign: TextAlign.center,
        //               ),
        //             ),
        //             SizedBox(height: 10),
        //             Container(
        //               height: 2,
        //               width: MediaQuery.of(context).size.width *
        //                   0.75, // Visible line
        //               color: Colors.white,
        //             ),
        //             SizedBox(height: 20),
        //             ElevatedButton(
        //               onPressed: () {
        //                 Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) => EditProfilePage(
        //                             onUpdateProfile: updateProfile)));
        //               },
        //               style: ElevatedButton.styleFrom(
        //                 backgroundColor: myFadedOrange,
        //                 shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(20),
        //                 ),
        //                 minimumSize:
        //                     Size(MediaQuery.of(context).size.width, 50),
        //               ),
        //               child: Text('Edit', style: TextStyle(fontSize: 20)),
        //             ),
        //             SizedBox(height: 20),
        //             BlocBuilder<AuthBloc, AuthState>(
        //               builder: (context, state) {
        //                 if (state is AuthStateIsLoading) {
        //                   return CircularProgressIndicator(
        //                     color: const Color.fromARGB(255, 255, 255, 255),
        //                   );
        //                 }
        //                 return ElevatedButton(
        //                   onPressed: () {
        //                     context
        //                         .read<AuthBloc>()
        //                         .add(LogOut(authRepository));
        //                   },
        //                   style: ElevatedButton.styleFrom(
        //                     backgroundColor: myFadedOrange,
        //                     shape: RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.circular(20),
        //                     ),
        //                     minimumSize:
        //                         Size(MediaQuery.of(context).size.width, 50),
        //                   ),
        //                   child: Text(
        //                     'Log Out',
        //                     style: TextStyle(fontSize: 20),
        //                   ),
        //                 );
        //               },
        //             ),
        //           ],
        //         ),
        //       ),
        //     )

        //     // Expanded(
        //     //   child: GridView.builder(
        //     //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     //         crossAxisCount: 2, childAspectRatio: 1),
        //     //     shrinkWrap: true,
        //     //     physics: NeverScrollableScrollPhysics(),
        //     //     itemCount: profiles.length,
        //     //     //itemExtent: 150.0,
        //     //     itemBuilder: (context, index) {
        //     //       final profile = profiles[index];

        //     //       return ListTile(
        //     //         title: Container(
        //     //           // decoration: BoxDecoration(
        //     //           //   gradient: RadialGradient(
        //     //           //     colors: [
        //     //           //       Color.fromARGB(22, 255, 255, 255),
        //     //           //       Color.fromARGB(0, 255, 255, 255),
        //     //           //     ],
        //     //           //     center: Alignment.center,
        //     //           //   ),
        //     //           //   borderRadius: BorderRadius.circular(40.0),
        //     //           //   boxShadow: [
        //     //           //     BoxShadow(
        //     //           //       color: Color.fromARGB(78, 255, 255, 255),
        //     //           //       offset: Offset(0, 5),
        //     //           //       blurRadius:
        //     //           //           0.0, // Increased blur radius for a blurry effect
        //     //           //     ),
        //     //           //   ],
        //     //           // ),
        //     //           margin: EdgeInsets.all(0.0),
        //     //           child: Column(
        //     //             mainAxisAlignment: MainAxisAlignment.start,
        //     //             children: [
        //     //               //SizedBox(width: 20.0),
        //     //               Container(
        //     //                 width: 80.0,
        //     //                 height: 80.0,
        //     //                 child: CircleAvatar(
        //     //                   child: profile['icon'],
        //     //                   backgroundColor:
        //     //                       Color.fromARGB(224, 33, 33, 33),
        //     //                 ),
        //     //               ),
        //     //               //SizedBox(width: 20.0),
        //     //               Column(
        //     //                 crossAxisAlignment: CrossAxisAlignment.center,
        //     //                 children: [
        //     //                   SizedBox(height: 20),
        //     //                   Text(
        //     //                     profile['title'].toString(),
        //     //                     textAlign: TextAlign.center,
        //     //                     style: TextStyle(
        //     //                       fontSize: 20.0,
        //     //                       fontWeight: FontWeight.bold,
        //     //                       color: Color.fromARGB(255, 120, 188, 156),
        //     //                     ),
        //     //                   ),
        //     //                   SizedBox(height: 10),
        //     //                   Text(
        //     //                     profile['data'].toString(),
        //     //                     textAlign: TextAlign.center,
        //     //                     style: TextStyle(
        //     //                         fontSize: 16.0, color: Colors.white),
        //     //                   ),
        //     //                 ],
        //     //               ),
        //     //             ],
        //     //           ),
        //     //         ),
        //     //       );
        //     //     },
        //     //   ),
        //     // )
        //   ],
        // )
      ),
    );
  }
}
