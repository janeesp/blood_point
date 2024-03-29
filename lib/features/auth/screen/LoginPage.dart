import 'package:arabic_font/arabic_font.dart';
import 'package:blood_point/features/auth/screen/sign_page.dart';
import 'package:blood_point/features/auth/screen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../../core/global/global.dart';
import '../../home/screen/home_page.dart';
import '../authController/authController.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState createState() => _LogonPaheState();
}

class _LogonPaheState extends ConsumerState<LoginPage> {
  LoginData() {
    ref
        .watch(AuthControllerProvider)
        .LoginData(email.text.trim(), password.text.trim(), context);
  }

  RegExp Emailvalidator =
      RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+$)");
  // RegExp Passwordvalidator=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[./@!&%$#]).{8,}$');

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool eye = false;
  final passwordprovider = StateProvider<bool>((ref) {
    return false;
  });
  @override
  Widget build(BuildContext context) {
    // var scrHeight = MediaQuery.of(context).size.height;
    // var scrWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Consumer(
              builder: (context, ref, child) {
                final passwordvisble = ref.watch(passwordprovider);
                return Column(
                  children: [
                    SizedBox(
                      height: scrHeight * 0.05,
                    ),
                    Container(
                      height: scrHeight * 0.25,
                      child: Image.asset('aseets/Logo.jpg'),
                    ),

                    const Text(
                      'Login',
                      style: ArabicTextStyle(
                          arabicFont: ArabicFont.amiri, fontSize: 50),
                    ),

                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          prefixIconColor: Colors.black12,
                          contentPadding:
                              const EdgeInsets.only(top: 30, left: 10),
                          // prefixIcon: Icon(Icons.person),
                          hintText: "email"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (!Emailvalidator.hasMatch(value!)) {
                          return "enter email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: scrHeight * 0.02,
                    ),
                    TextFormField(
                      controller: password,
                      maxLength: 15,
                      obscureText: !passwordvisble,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 30, left: 10),
                          prefixIconColor: Colors.black12,
                          // prefixIcon: const Icon(Icons.lock_outline_rounded),
                          hintText: "password",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              ref.watch(passwordprovider.notifier).state =
                                  !passwordvisble;
                            },
                            child: !passwordvisble
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: (value) {
                      //   if(!Passwordvalidator.hasMatch(value!)){
                      //     return "enter password";
                      //   }else{
                      //     return null;
                      //   }
                      // },
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     // SizedBox(width: width*0.09,),
                    //     // //const Text('Forgot password',style: TextStyle(fontWeight: FontWeight.bold),),
                    //     // SizedBox(width: width*0.35,),
                    //     const Text('Forgot password',
                    //         style: TextStyle(fontWeight: FontWeight.bold))
                    //   ],
                    // ),
                    SizedBox(
                      height: scrHeight * 0.07,
                    ),

                    InkWell(
                      onTap: () {
                        if (email.text.trim().isNotEmpty &&
                            password.text.trim().isNotEmpty) {
                          LoginData();
                        } else {
                          email.text.isEmpty
                              ? showErorMessage(context, 'enter email')
                              : showErorMessage(context, 'enter password');
                        }
                      },
                      child: Container(
                        height: scrHeight * 0.07,
                        // width: width*0.9,
                        decoration: BoxDecoration(
                            color: const Color(0xffeb0216),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Center(
                            child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignPage(),
                            ));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Don't hve a account ? ",
                              style: ArabicTextStyle(
                                  arabicFont: ArabicFont.amiri, fontSize: 15),
                            ),
                            Text(
                              'SIGHN Up',
                              style: ArabicTextStyle(
                                  arabicFont: ArabicFont.lalezar, fontSize: 15),
                            )
                          ],
                        ),
                      ),

                    ),

                    GestureDetector(
                        onTap: () {
                          ref
                              .watch(AuthControllerProvider)
                              .signWithGoogle(context);
                          // ref.read(AuthControllerProvider).SignwithGoole(context);
                        },
                        child: Container(
                          height: scrHeight*0.05,
                          width: scrWidth*0.4,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: AssetImage('aseets/google.jpg'))
                          ),



                        )),
                  ],
                );
              },
            )),
      ),
    );
  }
}
