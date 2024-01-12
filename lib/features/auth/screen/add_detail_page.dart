import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_project_name/core/global/global.dart';
import 'package:your_project_name/features/home/screen/home_page.dart';

import '../../../core/providers/utils.dart';

class Add_detail_Page extends ConsumerStatefulWidget {
  const Add_detail_Page({super.key});

  @override
  ConsumerState createState() => _Add_detail_PageState();
}

class _Add_detail_PageState extends ConsumerState<Add_detail_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Padding(
       padding: const EdgeInsets.all(8.0),
       child:
           Consumer(builder: (context, ref, child) {
             return  Column(
               children: [
                SizedBox(
                  height:scrHeight*0.05,
                ),
                 const Padding(
                   padding: EdgeInsets.all(8.0),
                   child:  Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text('Add Detals',style: ArabicTextStyle(arabicFont: ArabicFont.amiri,fontSize: 50),),
                     ],
                   ),
                 ),
                 Divider(),
                  SizedBox(
                    height: scrHeight*0.04,
                  ),

                 TextFormField(
                   decoration: InputDecoration(
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(15)
                     )
                   ),
                 ),
                 SizedBox(height: scrHeight*0.02,),
                 TextFormField(
                   decoration: InputDecoration(
                       border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15)
                       )
                   ),
                 ),
                 SizedBox(height: scrHeight*0.02,),
                 TextFormField(
                   decoration: InputDecoration(
                       border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15)
                       )
                   ),
                 ),
                 SizedBox(height: scrHeight*0.02,),
                 TextFormField(
                   decoration: InputDecoration(
                       border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15)
                       )
                   ),
                 ),
                 SizedBox(height: scrHeight*0.02,),
                 TextFormField(
                   decoration: InputDecoration(
                       border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15)
                       )
                   ),
                 ),
                 SizedBox(height: scrHeight*0.18 ,),
                 Container(
                   height: scrHeight*0.07,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15),
                     color: primaryColor
                   ),
                   child: const Center(
                     child: Text('Add',style: ArabicTextStyle(arabicFont: ArabicFont.amiri),),
                    ),
                 )
               ],
             );
           },)

     ),
    );
  }
}
