import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/userModel.dart';
import '../../home/screen/home_page.dart';
import 'LoginPage.dart';
String currentUserId='';

Map<String,dynamic>currentUserdata={};

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  Future loginEvent() async {
    final preferences = await SharedPreferences.getInstance();
    if(preferences.containsKey('id')){
      currentUserId=preferences.getString('id')??'';
    }
    if(currentUserId != ''){
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
                currentUserId!=""
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
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Container(
            // height:width*2,
            //   width: width*1,
              child: Image(image: AssetImage('aseets/gifffff (1).gif'))),

      ),
    );
  }
}
