import 'package:blood_point/core/const/constants.dart';
import 'package:blood_point/core/providers/Faillure.dart';
import 'package:blood_point/core/providers/Typedufe.dart';
import 'package:blood_point/core/providers/providers.dart';
import 'package:blood_point/main.dart';
import 'package:blood_point/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

final AuthRepositoryProvider = Provider((ref) => AuthRepository(
    firestore: ref.watch(firebaseProvider), auth: ref.watch(authProvider)));

class AuthRepository {
  FirebaseAuth _auth;
  FirebaseFirestore _firestore;
  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _auth = auth,
        _firestore = firestore;
  addSignUp(UserModel emailAuth) {
    UserModel addEmail;
    _auth
        .createUserWithEmailAndPassword(
      email: emailAuth.email.trim(),
      password: emailAuth.password.trim(),
    )
        .then((value) {
      addEmail = UserModel(
          email: emailAuth.email.trim(),
          password: emailAuth.password.trim(),
          name: emailAuth.name.trim(),
          id: emailAuth.id);
      _firestore
          .collection(FirebaseConst.Users)
          .add(addEmail.toMap())
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
          userModel = UserModel.fromMap(user.docs[0].data());
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
}
