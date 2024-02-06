import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/detailsModel.dart';
import '../../auth/screen/splashScreen.dart';
import '../controller/addController.dart';
import 'home_page.dart';

class AllItems extends ConsumerStatefulWidget {
  String group;
  AllItems({super.key, required this.group});

  @override
  ConsumerState createState() => _AllItemsState();
}

class _AllItemsState extends ConsumerState<AllItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              child: Consumer(
                builder: (context, ref, child) {
                  var detailItems =
                      ref.watch(getDetailsControllerProvider(widget.group));
                  return detailItems.when(
                    data: (data) {
                      data.isEmpty ? Text('eror') : print(detailItems);
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: detailItems.value!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          DetailsModel detailItems = data[index];
                          return Padding(
                            padding: EdgeInsets.all(scrWidth * 0.03),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                // margin: EdgeInsets.only(top: 3,left: 2),
                                //  height: width * 0.35,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 245, 243, 243),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        offset: Offset(0, 0.2),
                                      )
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Name            :  ',
                                            style: ArabicTextStyle(
                                                arabicFont: ArabicFont.amiri),
                                          ),
                                          Text(
                                            detailItems.name,
                                            style: ArabicTextStyle(
                                                arabicFont: ArabicFont.amiri),
                                            // 'name${detailItems.name}'
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: scrHeight * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'phone            :  ',
                                            style: ArabicTextStyle(
                                                arabicFont: ArabicFont.amiri),
                                          ),
                                          GestureDetector(
                                   onTap: () {
                                     void _launchURL() async {
                                       if (!await launch('tel://${detailItems.number.toString()}')) throw 'Could not launch ';
                                     }
                                     _launchURL();
                                   },
                                            child: Text(
                                              detailItems.number.toString(),
                                              style: const ArabicTextStyle(
                                                  arabicFont: ArabicFont.amiri,color: Colors.blue),

                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: scrHeight * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'place             :  ',
                                            style: ArabicTextStyle(
                                                arabicFont: ArabicFont.amiri),
                                          ),
                                          Text(
                                            detailItems.place,
                                            style: ArabicTextStyle(
                                                arabicFont: ArabicFont.amiri),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: scrHeight * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Bloudgroup    :  ',
                                            style: ArabicTextStyle(
                                                arabicFont: ArabicFont.amiri),
                                          ),
                                          Text(
                                            detailItems.bloodGroup,
                                            style: ArabicTextStyle(
                                                arabicFont: ArabicFont.amiri),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) {
                      print(error);
                      return Text(error.toString());
                    },
                    loading: () =>
                        Center(child: const CircularProgressIndicator()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
