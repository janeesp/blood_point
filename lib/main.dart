
import 'package:blood_point/features/home/screen/home_page.dart';
import 'package:blood_point/features/home/screen/listPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/auth/screen/LoginPage.dart';
import 'firebase_options.dart';

var currentUserId = FirebaseAuth.instance.currentUser?.uid;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
       // home: Home(),
         home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
