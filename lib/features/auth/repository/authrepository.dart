
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/const/constants.dart';
import '../../../core/providers/Faillure.dart';
import '../../../core/providers/Typedufe.dart';
import '../../../core/providers/providers.dart';
import '../../../main.dart';
import '../../../model/userModel.dart';
import '../screen/add_detail_page.dart';
import '../screen/splashScreen.dart';

final AuthRepositoryProvider = Provider((ref) => AuthRepository(
    firestore: ref.watch(firebaseProvider),
    googleSignIn: ref.watch(googlesignin),
    auth: ref.watch(authProvider)));

class AuthRepository {
  FirebaseAuth _auth;
  FirebaseFirestore _firestore;
  final GoogleSignIn _googleSinIn;
  AuthRepository( {
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
  _googleSinIn = googleSignIn,
        _firestore = firestore;

  addSignUp(UserModel emailAuth) {
    UserModel addEmail;
    _auth
        .createUserWithEmailAndPassword(
      email: emailAuth.email!.trim(),
      password: emailAuth.password!.trim(),
    )
        .then((value) {
      addEmail = UserModel(
        delete: false,
          name: emailAuth.name!.trim(),
          email: emailAuth.email!.trim(),
          password: emailAuth.password!.trim(),
          id: emailAuth.id);
      _firestore
          .collection(FirebaseConst.Users)
          .add(addEmail.tojson())
          .then((value) => value.update({"id": value.id}));
    });
  }

  FutureEither<UserModel> LoginData(String email, password) async {
    UserModel? userModel;
    try {
      var user = await _firestore
          .collection(FirebaseConst.Users)
          .where('email', isEqualTo: email)
          .get();
      if (user.docs.isEmpty) {
        throw "Please Enter Valid User Id";
      } else {
        if (user.docs[0]['password'] == password &&
            user.docs[0]['email'] == email) {
          SharedPreferences? pref = await SharedPreferences.getInstance();
          pref.setString('id', user.docs[0]['id']);
          pref.setString('pas', user.docs[0]['password']);
          currentUserId = user.docs[0]['id'];
          userModel = UserModel.fromjson(user.docs[0].data());
        }
      }
      // await _auth.signInWithEmailAndPassword(email: email, password: password);

      return right(userModel!);
    } on FirebaseException catch(e){
  throw e.message!;
    }catch (e){
      return left(Failure(e.toString()));
    }
  }
  GogoleSigIn(BuildContext context)async{
    try{
    UserCredential userCredential;
    final GoogleSignInAccount? googleuser = await _googleSinIn.signIn();
    if(googleuser != null){
      print('111111111');
   final googleauth = await googleuser.authentication;
   final credential = GoogleAuthProvider.credential(
     accessToken: googleauth?.accessToken,
     idToken:  googleauth?.idToken,
   );
  userCredential = await _auth.signInWithCredential(credential);
 final email = userCredential.user!.email;
 print('2222222');
  final usersnapshoot= await _user.where('email',isEqualTo: email).get();

  UserModel? userModel;
  if(usersnapshoot.docs.isNotEmpty){
    print('3333333');
    userModel =UserModel.fromjson(
      usersnapshoot.docs[0].data() as Map<String,dynamic>,
    );
  }else{
    print('44444444');
   userModel= UserModel(
     //createrddate: DateTime.now(),
     delete: false,
     email: userCredential.user!.email,
     id:userCredential.user!.uid,
   );
   print('55555555');
   await _user.doc(userCredential.user!.uid).set(userModel.tojson());
  }
  print('6666666666');
 Navigator.push(context,MaterialPageRoute(builder: (context) => Add_detail_Page(
   name: userCredential.user!.displayName,
   email: userCredential.user!.email,
 ),));
    }
    }catch(e){
      print('777777');
      print('eror sign in $e');
    }
  }
  CollectionReference get _user{
 return FirebaseFirestore.instance.collection('user');
  }
}
