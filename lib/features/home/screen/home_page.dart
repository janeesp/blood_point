import 'package:arabic_font/arabic_font.dart';
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
                appBar: AppBar(
                  title: const Text(
                    'Hai ',
                    style: ArabicTextStyle(
                        arabicFont: ArabicFont.amiri,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () async {
                          Navigator.of(context, rootNavigator: true).pop(false);
                          final SharedPreferences localStorage =
                          await SharedPreferences.getInstance();
                          localStorage.clear();
                          print(localStorage.get('userId'));
                          print('localStorage.get()localStorage.get()');
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                   LoginPage()),
                                  (route) => false);
                        },
                        icon: const Icon(Icons.login_outlined))
                  ],
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
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddPage(),
                        ));
                  },
                  child: const Icon(Icons.add),
                ),
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
