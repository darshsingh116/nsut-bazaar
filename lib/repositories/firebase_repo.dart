import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nsutbazaar/models/User.dart';

class FirebaseRepository {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  late User user;
  late UserModel userModel;


  // String? getCurrentUserId() {
  //   User? user = firebaseAuth.currentUser;
  //   return user?.uid;
  // }

  Future<int> alreadyLoggedIn() async {
    User? user = await firebaseAuth.currentUser;

    if (user == null) {
      return 1;
    } else {
      this.user = user;
      var response =
          await firebaseFirestore.collection("Users").doc(user.uid).get();
      userModel = UserModel.fromMap(response.data()!);
      return 0;
    }
  }

  Future<int> login({required String email, required String password}) async {
    try {
      var userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print("loggedin1");
      user = userCredential.user!;

      var response =
          await firebaseFirestore.collection("Users").doc(user.uid).get();

      print(response.data()!);
      print("hui hui");
      print(response.data());

      userModel = UserModel.fromMap(response.data()!);

      return 1;
    } catch (e) {
      print("login error oho" + e.toString());
      return 0;
    }
  }

  Future<int> signUp(
      {required String email,
      required String password,
      required int phoneNumber,
      required String username,
      required String rollNumber,
      required String fullName}) async {
    //regsitration
    try {
      var userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user!;
//data model entry
      userModel = UserModel(
          uid: user.uid,
          username: username,
          email: user.email ?? "email",
          fullname: fullName,
          phoneNumber: phoneNumber,
          rollNumber: rollNumber,

          );
     

      //data model entry finished
      await firebaseFirestore
          .collection("Users")
          .doc(user.uid)
          .set(userModel.toJson());

      return 1;
    } on FirebaseAuthException catch (e) {
      print("login error oho" + e.toString());
      return 0;
      // if (e.code == 'weal-password') {
      //   throw Exception('This password is weak');
      // } else if (e.code == 'email-already-in-use') {
      //   throw Exception('Account already exists');
      // }
    } catch (e) {
      print("login error oho" + e.toString());
      return 0;
      //throw Exception(e.toString());
    }
  }

  Future<void> updateUserModel() async {
    print("user updated!");
    await firebaseFirestore
        .collection("Users")
        .doc(user.uid)
        .update(userModel.toJson());
  }


  

  // //get events model
  // Future<Object> getEvents() async {
  //   try {
  //     var response = await firebaseFirestore.collection("Events").get();
  //     //print("response");
  //     var list =
  //         response.docs.map((doc) => EventModel.fromMap(doc.data())).toList();
  //     //print("yes");
  //     //print(list[0].date);

  //     //give n num of ques
  //     return list;

  //     //return 1;
  //   } catch (e) {
  //     return [];
  //     //return 0;
  //   }
  // }

  Future<void> logOut() async {
    await firebaseAuth.signOut();
  }
}

/////////////////////////////////////


