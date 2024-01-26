import 'package:flutter/material.dart';

import 'Views/login.dart';
import 'Constant_Data/constants.dart';
import 'session/SessionManager.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      home: LoginScreen(),
    );
  }
}
