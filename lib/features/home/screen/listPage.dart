
import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        height: width*8,
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
                    padding:  EdgeInsets.all(width*0.03),
                    child: Container(
                     // margin: EdgeInsets.only(top: 3,left: 2),
                      height: width*0.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 2,
                              spreadRadius: 2,
                              offset: Offset(0, 0.2),

                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                detailItems.name
                                // 'name${detailItems.name}'
                            ),
                            SizedBox(
                              height: width*0.04,
                            ),
                            Text(detailItems.number.toString()),
                            SizedBox(
                              height: width*0.04,
                            ),
                            Text(detailItems.place),
                            SizedBox(
                              height: width*0.04,
                            ),
                            Text(detailItems.bloodGroup),

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
    );
  }
}
