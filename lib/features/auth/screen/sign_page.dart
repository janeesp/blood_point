import 'package:arabic_font/arabic_font.dart';
import 'package:blood_point/core/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/global/global.dart';
import '../../../model/userModel.dart';
import '../authController/authController.dart';
import 'LoginPage.dart';

class SignPage extends ConsumerStatefulWidget {
  const SignPage({super.key});

  @override
  ConsumerState createState() => _SignPageState();
}

class _SignPageState extends ConsumerState<SignPage> {
  SignData() {
    ref.watch(AuthControllerProvider).Sign(UserModel(
        delete: false,
        email: email_controler.text.trim(),
        password: password_controler.text.trim(),
        name: Name.text.trim(),
        id: ""));
  }

  RegExp Emailvalidator =
      RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+$)");
  // RegExp Passwordvalidator=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[./@!&%$#]).{8,}$');
  TextEditingController Name = TextEditingController();
  TextEditingController email_controler = TextEditingController();
  TextEditingController password_controler = TextEditingController();
  bool eye = false;

  @override
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: scrHeight * 0.03,
              ),
              Text(
                'Sign In',
                style:
                    ArabicTextStyle(arabicFont: ArabicFont.amiri, fontSize: 50),
              ),
              SizedBox(
                height: width * 0.02,
              ),
              Container(
                height: width * 0.5,
                child: const Image(image: AssetImage('aseets/Logo.jpg')),
              ),
              SizedBox(
                height: width * 0.08,
              ),
              TextFormField(
                controller: Name,
                decoration: const InputDecoration(
                    hintText: 'Name',
                    labelText: 'Name',
                    // prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              SizedBox(
                height: width * 0.04,
              ),
              TextFormField(
                controller: email_controler,
                decoration: const InputDecoration(

                    // prefixIcon: Icon(Icons.alternate_email),

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: "Email",
                    labelText: 'Email'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (!Emailvalidator.hasMatch(value!)) {
                    return "enter a valid email";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: width * 0.04,
              ),
              TextFormField(
                controller: password_controler,
                maxLength: 10,

                obscureText: eye == true ? false : true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusColor: Colors.black12,
                  hintText: "Password",
                  labelText: 'Password',
                  suffixIcon: GestureDetector(
                      onTap: () {
                        eye = !eye;
                        setState(() {});
                      },
                      child: eye == true
                          ? const Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.black38,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: Colors.black38,
                            )),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                // validator: (value) {
                //   if(!Passwordvalidator.hasMatch(value!)){
                //     return "enter password";
                //   }else{
                //     return null;
                //   }
                // },
              ),
              SizedBox(
                height: width * 0.3,
              ),
              InkWell(
                onTap: () {
                  if (Name.text.trim().isNotEmpty &&
                      email_controler.text.trim() != "" &&
                      password_controler.text.trim() != "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Submited Successfully")));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                    SignData();
                  } else {
                    Name.text == ''
                        ? showErorMessage(context, 'enter name')
                        : email_controler.text == ""
                            ? showErorMessage(context, 'enter email')
                            : showErorMessage(context, 'enter password');
                  }
                },
                child: Container(
                  height: width * 0.13,
                  width: width * 1,
                  decoration: BoxDecoration(
                      color: const Color(0xffeb0216),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                      child: Text(
                    "Sign up",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // Container(
                  //     height: width*0.18,
                  //     color: Colors.black,
                  //     width: width*0.15,
                  //
                  // child:
                  // SignInButton()
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
