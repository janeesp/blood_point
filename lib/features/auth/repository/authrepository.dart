import 'package:blood_point/features/auth/screen/splashScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

final AuthRepositoryProvider = Provider((ref) => AuthRepository(
    firestore: ref.watch(firebaseProvider),
    googleSignIn: ref.watch(googlesignin),
    auth: ref.watch(authProvider)));

class AuthRepository {
  FirebaseAuth _auth;
  FirebaseFirestore _firestore;
  final GoogleSignIn _googleSinIn;
  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _googleSinIn = googleSignIn,
        _firestore = firestore;

  FutureVoid addSignUp(
      UserModel emailAuth,
      ) async {
    UserModel addEmail;
    try{
      await _auth.createUserWithEmailAndPassword(
        email: emailAuth.email!.trim(),
        password: emailAuth.password!.trim(),
      )
          .then((value) async {
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
      SharedPreferences? pref = await SharedPreferences.getInstance();
      pref.setString('id', emailAuth.id.toString());
      return right("");
    }on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure('enter a valid email or password'));
    }

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
          pref.setString('email', user.docs[0]['email']);
          //currentUserId = user.docs[0]['id'];
          userModel = UserModel.fromjson(user.docs[0].data());
        }
      }
      // await _auth.signInWithEmailAndPassword(email: email, password: password);

      return right(userModel!);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure('enter a valid email or password'));
    }
  }

  // GogoleSigIn(BuildContext context) async {
  //   try {
  //     UserCredential userCredential;
  //     final GoogleSignInAccount? googleuser = await _googleSinIn.signIn();
  //     if (googleuser != null) {
  //       print('111111111');
  //       final googleauth = await googleuser.authentication;
  //       final credential = GoogleAuthProvider.credential(
  //         accessToken: googleauth?.accessToken,
  //         idToken: googleauth?.idToken,
  //       );
  //       userCredential = await _auth.signInWithCredential(credential);
  //
  //       final email = userCredential.user!.email;
  //       print('2222222');
  //       final usersnapshoot =
  //           await _user.where('email', isEqualTo: email).get();
  //
  //       UserModel? userModel;
  //       if (usersnapshoot.docs.isNotEmpty) {
  //         print('3333333');
  //         userModel = UserModel.fromjson(
  //           usersnapshoot.docs[0].data() as Map<String, dynamic>,
  //         );
  //       } else {
  //         print('44444444');
  //         userModel = UserModel(
  //           //createrddate: DateTime.now(),
  //           delete: false,
  //           email: userCredential.user!.email,
  //           id: userCredential.user!.uid,
  //         );
  //         print('55555555');
  //         await _user.doc(userCredential.user!.uid).set(userModel.tojson());
  //       }
  //       print('6666666666');
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => Add_detail_Page(
  //               name: userCredential.user!.displayName,
  //               email: userCredential.user!.email,
  //             ),
  //           ));
  //     }
  //   } catch (e) {
  //     print('777777');
  //     print('eror sign in $e');
  //   }
  // }
  FutureEither<UserModel> GogoleSigIn() async {
    try {
      await _auth.signOut();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSinIn.signIn();
      final googleAuth = await googleSignInAccount?.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      print(userCredential.user!.email);

      UserModel authModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString("id", userCredential.user!.uid ?? "");
        localStorage.setString("email", userCredential.user!.email ?? "");

        authModel = UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email ?? "",
          name: userCredential.user!.displayName ?? "no name",
        );
        await _firestore
            .collection(FirebaseConst.Users)
            .doc(userCredential.user!.uid)
            .set(authModel.tojson());
        return right(authModel);
      } else {
        var data = await _user
            .where("email", isEqualTo: userCredential.user!.email)
            .get();
        UserModel authModel =
            UserModel.fromjson(data.docs.first.data() as Map<String, dynamic>);
        return right(authModel);
      }
      // _firebaseAuth.signInWithCredential(credential);
    } on FirebaseException catch (e) {
      return left(Failure(e.message.toString()) as Failure);
    } catch (e) {
      return left(Failure(e.toString()) as Failure);
    }
  }

  Future<bool> emailexist({required String email}) async {
    final emailexist = await _firestore
        .collection(FirebaseConst.Users)
        .where('email', isEqualTo: email)
        .where('delete', isEqualTo: false)
        .get();
    return emailexist.docs.isNotEmpty;
  }

  CollectionReference get _user {
    return FirebaseFirestore.instance.collection('user');
  }
  Future<Either<Failure ,String>> keepLogin(SharedPreferences prefs) async {
    try{
      if (prefs.containsKey('id')) {
        currentUserId = prefs.getString('id')!;
        print("userId found");
        return right(currentUserId);
      } else {
        currentUserId = "";
        print("userId not found");
        return left(Failure(''));
      }
    } catch (e) {
      print("Error: $e");
      return Left(Failure("SharedPreferences error: $e"));
    }
  }
}
