import 'package:blood_point/core/providers/providers.dart';
import 'package:blood_point/features/auth/authController/authController.dart';
import 'package:blood_point/features/auth/screen/sign_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/global/global.dart';



class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState createState() => _LogonPaheState();
}

class _LogonPaheState extends ConsumerState<LoginPage> {

  LoginData(){
    ref.watch(AuthControllerProvider).LoginData(email.text.trim(), password.text.trim(), context);
  }
  RegExp Emailvalidator=RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+$)");
  // RegExp Passwordvalidator=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[./@!&%$#]).{8,}$');

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  bool eye=false;
  @override
  Widget build(BuildContext context) {
   var width= MediaQuery.of(context).size.width;
    return Scaffold(
     body: SingleChildScrollView(
       child: Column(
         children: [
           SizedBox(
             height: width*0.2,
           ),
           Container(
             height: width*0.4,
             width: width*0.4,
             decoration:const BoxDecoration(
                 // image: DecorationImage(image: AssetImage('assets/animation/image.webp'))
             ) ,
           ),
           SizedBox(
             height: width*0.1,
           ),

           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
               height: width*0.13,
               decoration: BoxDecoration(
                   color: Colors.black12,
                   borderRadius: BorderRadius.circular(10)
               ),
               child: TextFormField(
                 controller: email,
                 decoration: const InputDecoration(
                     prefixIconColor: Colors.black12,
                     contentPadding: EdgeInsets.all(10),
                     // prefixIcon: Icon(Icons.person),
                     hintText: "email: ",
                     border: InputBorder.none
                 ),
                 autovalidateMode: AutovalidateMode.onUserInteraction,
                 validator: (value) {
                   if(!Emailvalidator.hasMatch(value!)){
                     return "enter email";
                   }else{
                     return null;
                   }
                 },
               ),
             ),
           ),
           SizedBox(
             height: width*0.06,
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
               height: width*0.13,
               decoration: BoxDecoration(
                   color: Colors.black12,
                   borderRadius: BorderRadius.circular(10)
               ),
               child: TextFormField(
                 controller: password,
                 maxLength: 15,
                 obscureText: eye==true?false:true,
                 decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 30,left: 10),
                     prefixIconColor: Colors.black12,
                     // prefixIcon: const Icon(Icons.lock_outline_rounded),
                     hintText: "password",
                     suffixIcon: InkWell(
                         onTap: () {
                           eye=!eye;
                           setState(() {

                           });
                         },
                         child:eye==true? const Icon(Icons.remove_red_eye_outlined,color: Colors.black12,)
                             :const Icon(Icons.visibility_off,color: Colors.black12,)),
                     border: InputBorder.none
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
           ),
           SizedBox(
             height: width*0.08,
           ),


           Container(
             height: width*0.13,
             width: width*0.9,
             decoration: BoxDecoration(
                 color: primaryColor,
                 borderRadius: BorderRadius.circular(15)
             ),
             child: InkWell(
               onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignPage(),));
               },
               child: const Center(child: Text("Sign up",style: TextStyle(
                   fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)),
             ),
           ),
           SizedBox(
             height: width*0.07,
           ),
           InkWell(
             onTap: () {
               if(email.text.trim().isNotEmpty&&password.text.trim().isNotEmpty){
             LoginData();

               }else{

                 email.text.isEmpty?
                 showErorMessage(context,'enter email'):
                 showErorMessage(context,'enter password');
               }
             },
             child: Container(
               height: width*0.13,
               width: width*0.9,
               decoration: BoxDecoration(
                   color: primaryColor,
                   borderRadius: BorderRadius.circular(15)
               ),
               child: const Center(child: Text("Login",style: TextStyle(
                   fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)),
             ),
           ),
           SizedBox(height: width*0.02,),
           Row(
             children: [
               SizedBox(width: width*0.09,),
               const Text('Forgot password',style: TextStyle(fontWeight: FontWeight.bold),),
               SizedBox(width: width*0.35,),
               const Text('Creat an account',style: TextStyle(fontWeight: FontWeight.bold))
             ],
           ),
           SizedBox(height: width*0.1,),
           const Text('or',style:TextStyle(color: Colors.black38,fontSize: 25),),
           SizedBox(
             height: width*0.1,
           ),
           Row(
             children: [
               SizedBox(width: width*0.04,),
               Container(
                 height: width*0.14,
                 width: width*0.4,
                 decoration: const BoxDecoration(
                     // image: DecorationImage(image: AssetImage('assets/animation/insta.png')),
                     shape: BoxShape.circle

                 ),
               ),
               SizedBox(
                 width: width*0.17,
               ),

               Container(
                   height: width*0.18,
                   width: width*0.15,
                   decoration: const BoxDecoration(
                       shape: BoxShape.circle
                   ),

                   // child:
                   // SignInButton()
               )


             ],
           ),
         ],
       ),
     ),
    );
  }
}
