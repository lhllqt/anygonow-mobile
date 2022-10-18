import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screen/login/login_screen.dart';
import 'package:untitled/screen/signup/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: home(),
    );
  }
}

Widget home() {
  return LoginScreen();
}
