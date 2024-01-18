
import 'dart:ui';

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/providers/utils.dart';
import '../../../model/detailsModel.dart';
import '../controller/addController.dart';
import 'home_page.dart';

class AllItems extends ConsumerStatefulWidget {
  String group;
   AllItems({super.key,required this.group});

  @override
  ConsumerState createState() => _AllItemsState();
}

class _AllItemsState extends ConsumerState<AllItems> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image:DecorationImage(
              image: AssetImage("assets/Logo.jpg"),fit: BoxFit.fill,),
         ),
        height: width*8,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 8,
            sigmaY: 10,
          ),
          child: Consumer(
            builder: (context, ref, child) {
              var  detailItems = ref.watch(getDetailsControllerProvider(widget.group));
              return
              detailItems.when(data: (data) {
                print(detailItems);
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: detailItems.value!.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DetailsModel detailItems = data[index];
                    return  Padding(
                      padding:  EdgeInsets.all(width*0.015),
                      child: Container(
                       // margin: EdgeInsets.only(top: 3,left: 2),
                        height: width*0.5,
                        decoration: BoxDecoration(
                          // border: Border.all(),
                             color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 0.2),

                              )
                            ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16,left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  // detailItems.name
                                   'name : ${detailItems.name}'
                              ),
                              SizedBox(
                                height: width*0.04,
                              ),
                              InkWell(
                                onTap: () {
                                  void _launchURL() async{
                                    if (!await launch('tel://${detailItems.number.toString()}')) throw 'Could not launch ';
                                    }
                                    _launchURL();
                                },
                                child: Container(
                                  width: width*0.3,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: width*0.10,
                                        width: width*0.04,
                                         child: SvgPicture.asset("assets/call.svg"),
                                      ),
                                      SizedBox(width: width*0.02,),
                                      Text(detailItems.number.toString()),

                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: width*0.04,
                              ),
                              Text('place : ${detailItems.place}'),
                              SizedBox(
                                height: width*0.06,
                              ),
                              Text('bloodGroup : ${detailItems.bloodGroup}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },);
              },
                  error: (error, stackTrace) {
                print(error);
                    return Text(error.toString());
                  },
                  loading: () => Center(child: const CircularProgressIndicator()),);
            },

          ),
        ),
      ),
    );
  }
}
