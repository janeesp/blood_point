import 'package:arabic_font/arabic_font.dart';
import 'package:blood_point/features/auth/screen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/global/global.dart';
import '../../../core/providers/utils.dart';
import '../../home/screen/home_page.dart';

class Add_detail_Page extends ConsumerStatefulWidget {
  final email;
  final name;
  const Add_detail_Page({super.key, required this.email, required this.name});

  @override
  ConsumerState createState() => _Add_detail_PageState();
}

class _Add_detail_PageState extends ConsumerState<Add_detail_Page> {
  TextEditingController name = TextEditingController();
  final editprovid = StateProvider<bool>((ref) {
    return true;
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer(
            builder: (context, ref, child) {
              final edit = ref.watch(editprovid);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: scrHeight * 0.05,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add Details',
                            style: ArabicTextStyle(
                                arabicFont: ArabicFont.amiri, fontSize: 50),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: scrHeight * 0.05,
                    ),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                          hintText: widget.email,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                    SizedBox(
                      height: scrHeight * 0.02,
                    ),
                    TextFormField(
                      readOnly: edit!,
                      decoration: InputDecoration(
                          hintText: widget.name,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                    SizedBox(
                      height: scrHeight * 0.02,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Nick Name',
                          hintText: 'Nick Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: scrHeight * 0.02,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: scrHeight * 0.3,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
                      },
                      child: Container(
                        height: scrHeight * 0.07,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xffeb0216),
                        ),
                        child: const Center(
                          child: Text(
                            'Add',
                            style: ArabicTextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                arabicFont: ArabicFont.amiri),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
