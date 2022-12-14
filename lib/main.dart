import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/controller/location/location.dart';
import 'package:untitled/i18n.dart';
import 'package:untitled/screen/handyman/home_page/home_page_screen.dart';
import 'package:untitled/screen/home_page/home_page_screen.dart';
import 'package:untitled/screen/login/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:untitled/screen/reset_password/reset_password_screen.dart';
import 'package:untitled/screen/signup/verified-page.dart';
import 'package:untitled/service/db_service.dart';
import 'package:untitled/service/local_notification_service.dart';
import 'package:untitled/service/stripe.dart';
import 'package:firebase_core/firebase_core.dart';

GlobalController globalController = Get.put(GlobalController());

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.data.toString()}");
}

Future<void> main() async {
  var publishedKey = await StripeService.getPubKey();
  Stripe.publishableKey = publishedKey;
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await initDB();
  await dotenv.load(fileName: ".env");
  await globalController.getStates();
  // ZipcodeUser.determinePosition();
  if (globalController.db.get("user") != null) {
    globalController.user.value = globalController.db.get("user");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnyGoNow',
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('en')],
      translations: Messages(),
      locale: const Locale('en', 'US'),
      defaultTransition:
          Platform.isIOS ? Transition.cupertino : Transition.rightToLeft,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "TTNorm-Bold",
      ),
      home: home(),
    );
  }

  Widget home() {
    // print("Start app...");

    if (globalController.user.value.id != null) {
      var role = globalController.user.value.role;
      if (role == null || role == 0) {
        return HomePageScreen();
      } else {
        return HandymanHomePageScreen();
      }
    }
    return LoginScreen();
  }
}
