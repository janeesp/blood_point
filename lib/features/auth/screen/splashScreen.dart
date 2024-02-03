import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/userModel.dart';
import '../../home/screen/home_page.dart';
import 'LoginPage.dart';
String currentUserId='';
 var scrHeight;
 var  scrWidth;
Map<String,dynamic>currentUserdata={};

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  Future loginEvent() async {
    final preferences = await SharedPreferences.getInstance();
    if(preferences.containsKey('email')){
      currentUserId=preferences.getString('email')??'';
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
     scrHeight=MediaQuery.of(context).size.height;
      scrWidth=MediaQuery.of(context).size.width;
     // var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
            height:scrHeight*0.7,
              width: scrWidth*0.6,
              child: Image(image: AssetImage('aseets/gifffff (1).gif'))),

      ),
    );
  }
}
