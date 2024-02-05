import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsutbazaar/auth/bloc/auth_bloc.dart';
import 'package:nsutbazaar/firebase_storage/bloc/firebase_storage_bloc.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/repositories/firebase_storage_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nsutbazaar/firebase_options.dart';
import 'package:nsutbazaar/auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseRepository>(
            create: (context) => FirebaseRepository()),
        RepositoryProvider<FirebaseStoreageRepo>(
            create: (context) => FirebaseStoreageRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
          BlocProvider<FirebaseStorageBloc>(
              create: (BuildContext context) => FirebaseStorageBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: Color.fromARGB(255, 7, 59, 118), // Darker blue color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(20.0), // Adjust the radius as needed
                  bottomRight: Radius.circular(20.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
