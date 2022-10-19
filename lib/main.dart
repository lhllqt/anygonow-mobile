import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/i18n.dart';
import 'package:untitled/screen/login/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  GlobalController globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('en')],
      translations: Messages(),
      locale: const Locale('en', 'US'),
      defaultTransition:
          Platform.isIOS ? Transition.cupertino : Transition.rightToLeft,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "TTNorm-Bold"),
      home: home(),
    );
  }

  Widget home() {
    return LoginScreen();
  }
}
