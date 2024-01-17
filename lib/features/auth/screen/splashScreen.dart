import 'dart:async';

import 'package:blood_point/features/home/screen/home_page.dart';
import 'package:blood_point/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/userModel.dart';
import 'LoginPage.dart';
var currentUserId=FirebaseAuth.instance.currentUser?.uid;
 String currentuserId="";
Map<String,dynamic>currentUserdata={};

// class SplashScreen extends ConsumerStatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   ConsumerState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends ConsumerState<SplashScreen> {
//   String? email;
//   String? password;
//   Future<void>checkLogin() async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     email= pref.getString("email");
//     password = pref.getString("password");
//     Future.delayed(Duration(seconds: 3));
//     if(currentUserId!=null){
//       Navigator.push(context, MaterialPageRoute(builder: (context) =>Home(),));
//     }
//     else{
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
//     }
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     Future.delayed(const Duration(seconds: 3)).then((value) => checkLogin());
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  const Scaffold(
//       backgroundColor: Colors.red,
//       body: Center(
//         child:
//
//         CircularProgressIndicator(),
//       ),
//     );
//   }
// }

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  Future loginEvent() async {
    final preferences = await SharedPreferences.getInstance();
    if (currentUserId != null) {
      preferences.setString('id', currentUserId!);
    }
    else{
      currentUserId = preferences.getString('id') ?? "";
    }
    if(currentUserId == null && currentUserId != ''){
      FirebaseFirestore.instance
          .collection("posUser")
          .doc(currentUserId)
          .snapshots()
          .listen((event) {
        currentUser = UserModel.fromjson(event.data()!);
      });
    }
    print('UserId : ${currentUserId!}');
    print('UserId : ${currentUser?.email}');
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    loginEvent().whenComplete(() async {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                currentUserId != ""
                    ? Home()
                    :  LoginPage()
            ),
                (route) => false);
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
