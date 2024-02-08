
import 'package:blood_point/features/auth/screen/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/providers/utils.dart';
import '../../../model/userModel.dart';
import '../../home/screen/home_page.dart';
import '../repository/authrepository.dart';
final AuthControllerProvider = Provider((ref){
  return AuthController(repository: ref.watch(AuthRepositoryProvider));

});
class AuthController{
AuthRepository _repository;
AuthController({
  required AuthRepository repository
}):
    _repository=repository;

Sign(UserModel userModel,BuildContext context) async {
  var result=await _repository.addSignUp(userModel);
result.fold((l) => showSnackBar(context,l.message),
        (r)async{
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Submited Successfully")));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
                  (route) => false);
      // Navigator.push(context, MaterialPageRoute(builder:(context) => Home(), ));

    });
}
LoginData(String email , password,BuildContext context)async{
 var result = await _repository.LoginData(email, password);
 result.fold((l) => showSnackBar(context,l.message),
         (r)async{
     final SharedPreferences prfs= await SharedPreferences.getInstance();
     prfs.setString("emai", email);
     prfs.setString("password", password);
     // Navigator.push(context, MaterialPageRoute(builder:(context) => Home(), ));
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home(),), (route) => false);
         });
}
// SignwithGoole(BuildContext context)async{
//   _repository.signInWithGoogle();
// }
  signWithGoogle(BuildContext context) async {
    // state = true;
    var res = await _repository.GogoleSigIn();
    res.fold(
            (l) => showSnackBar(context, l.toString()),
            (r) async {
          final SharedPreferences preferences = await  SharedPreferences.getInstance();
          preferences.setString("email",r.email.toString() );
          preferences.setString("id",r.id.toString() );
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),),
                  (route) => false);
        }
    );
  }
  Future<void> keepLogin(BuildContext context, SharedPreferences prefs) async{
    final data = await _repository.keepLogin(prefs);
    data.fold(
            (l) async {
          await Future.delayed(Duration(seconds: 3));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
                  (route) => false);
        },
            (r) async{
          await  Future.delayed(Duration(seconds: 3));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
                  (route) => false);
        }
    );
  }
}
