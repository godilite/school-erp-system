import 'package:flutter/material.dart';
import 'package:fsm/views/auth/login.dart';
import 'package:fsm/views/home_layout.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Management',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final bool isLoggedIn = false;
  final Box userBox = Hive.box('userBox');

  @override
  Widget build(BuildContext context) {
    String token = userBox.get('token');
    return isLoggedIn ? HomeLayout() : LoginPage();
  }
}
