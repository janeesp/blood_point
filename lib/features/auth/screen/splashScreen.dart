import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';
import '../../../model/userModel.dart';
import '../../home/screen/home_page.dart';
import '../authController/authController.dart';
import 'LoginPage.dart';
 String currentUserId='';

 var scrHeight;
 var  scrWidth;

Map<String,dynamic>currentUserdata={};

class Splashscreen extends ConsumerStatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  ConsumerState<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends ConsumerState<Splashscreen> {

 //  Future loginEvent() async {
 //    try{
 //      final preferences = await SharedPreferences.getInstance();
 //      if(preferences.containsKey('id')){
 //        // currentUserId=preferences.getString('email')??'';
 //        currentUserId=preferences.getString('id')??'';
 //      }
 //      if(currentUserId != ''){
 //        FirebaseFirestore.instance
 //            .collection("posUser")
 //            .doc(currentUserId)
 //            .snapshots()
 //            .listen((event) {
 //          currentUser = UserModel.fromjson(event.data()!);
 //        });
 //      }
 //      print('UserId : ${currentUser?.email}');
 //      print('bbbbbbbbbbbb');
 //      setState(() {});
 //    }catch(e){
 // print(e.toString());
 //    }
 //
 //  }
  loginEvent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // if (mounted) {
    ref.watch(AuthControllerProvider).keepLogin(context, preferences);
    // }
  }
  @override
  void initState() {
    loginEvent();
    // TODO: implement initState
    // loginEvent().whenComplete(() async {
    //   Timer(const Duration(seconds: 3), () {
    //     // Navigator.pushAndRemoveUntil(
    //     //     context,
    //     //     MaterialPageRoute(
    //     //         builder: (context) =>
    //     //         currentUserId!=""
    //     //             ? Home()
    //     //             :  LoginPage()
    //     //     ),
    //     //         (route) => false);
    //   });
    // });
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
