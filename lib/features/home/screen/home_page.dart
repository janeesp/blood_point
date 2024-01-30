import 'package:arabic_font/arabic_font.dart';
import 'package:blood_point/features/home/controller/addController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/screen/LoginPage.dart';
import '../../grouList/GroupController/groupController.dart';
import 'add People.dart';
import 'listPage.dart';

var width;

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Consumer(
      builder: (context, ref, child) {
        var items = ref.watch(getGroupProvider);
        return items.when(
          data: (data) {
            return DefaultTabController(
              length: data.groups!.length,
              child: Scaffold(
                drawer: Drawer(
                  width: width * 0.6,
                  child: ListView(
                    children: [
                      DrawerHeader(
                          decoration: const BoxDecoration(color: Color(0xffeb0216)),
                          child: Column(
                            children: [
                              Container(
                                height: width * 0.28,
                                width: width * 0.35,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('aseets/Logo.jpg')),
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                height: width * 0.01,
                              ),
                              const Text(
                                'GENIUS RED CROSS SQUAD',
                                style: ArabicTextStyle(
                                    arabicFont: ArabicFont.amiri,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          )),
                      ListTile(
                        title: InkWell(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('contact us'),
                                  actions: [
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Text('sabeer        :9496876904'),
                                              SizedBox(
                                                height: width * 0.05,
                                              ),
                                              Text('mushthaque: 9847534882'),
                                              SizedBox(
                                                height: width * 0.05,
                                              ),
                                            ],
                                          ),
                                        ])
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            child: const Text(
                              'contact us',
                              style: ArabicTextStyle(
                                  arabicFont: ArabicFont.amiri,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      // const ListTile(
                      //   title: Text(
                      //     'Helpline number',
                      //     style: ArabicTextStyle(
                      //         arabicFont: ArabicFont.amiri,
                      //         fontWeight: FontWeight.w500,
                      //         fontSize: 20),
                      //   ),
                      // ),
                       ListTile(
                        title: InkWell(
                          onTap: () async{
                            Navigator.of(context, rootNavigator: true).pop(false);
                            final SharedPreferences prfs =
                                await SharedPreferences.getInstance();
                            prfs.clear();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                                    (route) => false);
                          },
                          child: const Text(
                            'Log Out',
                            style: ArabicTextStyle(
                                arabicFont: ArabicFont.amiri,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                appBar: AppBar(
                  // title: const Text(
                  //   'Hai ',
                  //   style: ArabicTextStyle(
                  //       arabicFont: ArabicFont.amiri,
                  //       fontSize: 20,
                  //       color: Colors.white),
                  // ),
                  // actions: [
                  //   IconButton(
                  //       onPressed: () async {
                  //         Navigator.of(context, rootNavigator: true).pop(false);
                  //         final SharedPreferences prfs =
                  //             await SharedPreferences.getInstance();
                  //         prfs.clear();
                  //
                  //         Navigator.pushAndRemoveUntil(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) => LoginPage(),
                  //             ),
                  //             (route) => false);
                  //       },
                  //       icon: const Icon(Icons.login_outlined))
                  // ],
                  bottom: TabBar(
                    tabs: data.groups!
                        .map((e) => Tab(
                              child: Container(
                                height: 25,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Center(
                                    child: Text(e),
                                  ),
                                ),
                              ),
                              //text: e,
                            ))
                        .toList(),
                    labelColor: Color.fromARGB(255, 0, 0, 0),
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    isScrollable: true,
                    indicatorColor: Color.fromARGB(255, 15, 0, 0),
                    unselectedLabelColor: Colors.black,
                  ),
                  backgroundColor: const Color(0xffeb0216),
                ),
                body: TabBarView(
                    children: List.generate(data.groups!.length, (int index) {
                  return AllItems(group: data.groups![index]);
                })),
                // floatingActionButton: FloatingActionButton(
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => const AddPage(),
                //         ));
                //   },
                //   child: const Icon(Icons.add),
                // ),
              ),
            );
          },
          error: (error, stackTrace) {
            return Text(error.toString());
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
