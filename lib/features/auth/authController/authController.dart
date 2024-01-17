
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

Sign(UserModel userModel){
  _repository.addSignUp(userModel);
}
LoginData(String email , password,BuildContext context)async{
 var result = await _repository.LoginData(email, password);
 result.fold((l) => showSnackBar(context,l.message),
         (r)async{
     final SharedPreferences prfs= await SharedPreferences.getInstance();
     prfs.setString("emai", email);
     prfs.setString("password", password);
     Navigator.push(context, MaterialPageRoute(builder:(context) => Home(), ));
         });
}
SignwithGoole(BuildContext context)async{
  _repository.GogoleSigIn(context);
}
}
