import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/screen/handyman/main/main_screen.dart';
import 'package:untitled/screen/handyman/user/user_screen.dart';
import 'package:untitled/widgets/bottom_navigator.dart';

class HandymanHomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigatorHandyman(),
      body: PageView(
        controller: Get.put(GlobalController()).pageController,
        children: [
          HandymanMainScreen(),
          HandymanUserScreen(),
        ],
      ),
    );
  }
}
