
import 'package:blood_point/features/auth/screen/LoginPage.dart';
import 'package:blood_point/features/grouList/GroupController/groupController.dart';
import 'package:blood_point/features/home/screen/listPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add People.dart';
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
    return
      Consumer(
        builder: (context, ref, child) {
          var items= ref.watch(getGroupProvider);
          return items.when(
              data: (data) {
                return  DefaultTabController(
                  length: data.groups!.length,
                  child: Scaffold(

                    appBar: AppBar(
                      actions: [
                        IconButton(onPressed:
                            () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
                        }, icon:const Icon(Icons.logout_outlined))
                      ],
                      bottom:  TabBar(tabs:
                        data.groups!.map((e) => Tab(text: e,)).toList(),
                        labelColor: Colors.white,
                        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                        isScrollable: true,
                        indicatorColor: Colors.black,
                        unselectedLabelColor: Colors.black,
                      ),backgroundColor: const Color(0xffeb0216),
                    ),

                    body:
                    TabBarView(
                        children:
                        List.generate(data.groups!.length, ( int index){

                          return AllItems(group: data.groups![index]);
                        })
                    ),
                    floatingActionButton:FloatingActionButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPage(),)) ;
                      },child: const Icon(Icons.add),),


                  ),


                );
              },
              error: (error, stackTrace) {
                return Text(error.toString());
              },
              loading: () => const Center(child: CircularProgressIndicator()),);

        },
      );

  }
}
