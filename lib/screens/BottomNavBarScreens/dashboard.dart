import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsutbazaar/models/User.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/widgets/backgroundContainer.dart';


class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Text("hi")),
      ),
    );
  }
}
