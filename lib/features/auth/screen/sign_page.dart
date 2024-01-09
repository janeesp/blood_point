
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
  SignData(){
    ref.watch(AuthControllerProvider).Sign(UserModel(
        email: email_controler.text.trim(),
        password: password_controler.text.trim(),
        name: Name.text.trim(),
        id: ""));
  }
  RegExp Emailvalidator=RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+$)");
  // RegExp Passwordvalidator=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[./@!&%$#]).{8,}$');
  TextEditingController Name =TextEditingController();
  TextEditingController email_controler=TextEditingController();
  TextEditingController password_controler=TextEditingController();
  bool eye=false;

  @override
  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: width*0.3,
              ),
              Container(
                height: width*0.3,
                width: width*0.4,
                // child: const Image(image: AssetImage('assets/animation/image.webp')),

              ),
              SizedBox(
                height: width*0.08,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: Name,
                  decoration: const InputDecoration(
                      contentPadding:EdgeInsets.only(
                          left: 20,
                          top: 1
                      ) ,
                      prefixIconColor: Colors.black12,
                      hintText: 'name',
                      // prefixIcon: Icon(Icons.person),
                      border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(
                height: width*0.04,
              ),

              Container(
                height: width*0.12,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10),
                  color: Colors.black12,
                ),
                child: TextFormField(
                  controller: email_controler,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top:1,left: 20),
                    // prefixIcon: Icon(Icons.alternate_email),
                    prefixIconColor: Colors.black12,
                    focusColor: Colors.black12,
                    border: InputBorder.none,
                    hintText: "email",
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if(!Emailvalidator.hasMatch(value!)){
                      return
                        "enter email";
                    }else{
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: width*0.04,
              ),

              Container(
                height: width*0.12,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black12,
                ),

                child: TextFormField(
                  controller: password_controler,
                  maxLength: 10,

                  obscureText: eye==true?false:true,
                  decoration: InputDecoration(contentPadding: const EdgeInsets.only(left: 20,top: 40),
                    // prefixIcon: Icon(Icons.lock_outline_rounded),
                    prefixIconColor: Colors.black12,
                    border:  InputBorder.none,
                    focusColor: Colors.black12,

                    hintText: "password",
                    suffixIcon: InkWell(
                        onTap: () {
                          eye=!eye;
                          setState(() {

                          });
                        },
                        child:eye==true? const Icon(Icons.remove_red_eye_outlined,color: Colors.black38,)
                            :const Icon(Icons.visibility_off,color: Colors.black38,)),
                  ),
                  autovalidateMode:AutovalidateMode.onUserInteraction,
                  // validator: (value) {
                  //   if(!Passwordvalidator.hasMatch(value!)){
                  //     return "enter password";
                  //   }else{
                  //     return null;
                  //   }
                  // },
                ),
              ),

              SizedBox(
                height: width*0.04,
              ),
              InkWell(
                onTap: () {
                  if(Name.text.trim().isNotEmpty&&email_controler.text.trim()!=""&&password_controler.text.trim()!=""){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Submited Successfully")));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
                    SignData();
                  }else{

                    email_controler.text==""?
                    showErorMessage(context,'enter email') :
                    showErorMessage(context,'enter password');



                  }

                },
                child: Container(
                  height: width*0.13,
                  width: width*1,
                  decoration: BoxDecoration(
                      color: primaryColor,

                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: const Center(child: Text("Sign up",style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)),
                ),
              ),
              SizedBox(
                height: width*0.25,
              ),
              const Text('or Sign up with',style: TextStyle(
                  fontSize: 20,
                  color: Colors.black38
              ),),
              SizedBox(height: width*0.2,),
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
