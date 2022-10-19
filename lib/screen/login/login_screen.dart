import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/controller/login/login_controller.dart';
import 'package:untitled/controller/main/main_screen_controller.dart';
import 'package:untitled/screen/forgot_password/forgot_password_screen.dart';
import 'package:untitled/screen/handyman/home_page/home_page_screen.dart';
import 'package:untitled/screen/home_page/home_page_screen.dart';
import 'package:untitled/screen/signup/signup_screen.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/bounce_button.dart';
import 'package:untitled/widgets/input.dart';
import 'package:untitled/widgets/app_name.dart';

enum LoginOption { customer, professional }

class LoginScreen extends StatelessWidget {
  LoginPageController loginPageController = Get.put(LoginPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(top: getHeight(12)),
          child: confirmButtonContainer(context, loginPageController)),
      body: Container(
        padding: EdgeInsets.only(
          left: getWidth(16),
          right: getWidth(16),
          top: getHeight(62),
        ),
        color: const Color(0xFFFFFFFF),
        child: ListView(
          children: [
            getAppName(),
            SizedBox(
              height: getHeight(24),
            ),
            Text(
              'welcomeBack'.tr,
              style: TextStyle(
                fontSize: getWidth(24),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getHeight(4),
            ),
            Text(
              "Sign in to your account",
              style: TextStyle(
                fontSize: getWidth(16),
                color: const Color(0xff999999),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getHeight(40),
            ),
            Text("email_or_phone".tr,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500)),
            SizedBox(
              height: getHeight(4),
            ),
            inputRegular(context,
                hintText: "name@email.com",
                textEditingController: loginPageController.username),
            SizedBox(
              height: getHeight(24),
            ),
            Text("password".tr,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500)),
            SizedBox(
              height: getHeight(4),
            ),
            Obx(() => inputPassword(
              context,
              controller: loginPageController.password,
              hintText: "Enter your password",
              isHide: loginPageController.isHidePassword.value,
              changeHide: loginPageController.changeHidePassword,
            )),
            SizedBox(
              height: getHeight(24),
            ),
            Bouncing(
                child: const Text(
                  "Forgot your password?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                onPress: () => {Get.to(ForgotPasswordScreen())}),
          ],
        ),
      ),
    );
  }
}

Container layout({required Widget child}) {
  return Container(
    margin: EdgeInsets.only(
      bottom: getHeight(46),
      left: getWidth(16),
      right: getWidth(16),
    ),
    height: getHeight(108),
    width: double.infinity,
    child: child,
  );
}

Container confirmButtonContainer(
    BuildContext context, LoginPageController controller) {
  return layout(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xffff511a),
              side: const BorderSide(
                color: Color(0xffff511a),
              ),
            ),
            onPressed: () async {
              var result = await controller.login();
              if (result) {
                int? role = Get.put(GlobalController()).user.value.role;
                if (role == null || role == 0) {
                  await Get.put(MainScreenController()).getCategories();
                  Get.to(() => HomePageScreen());
                } else {
                  Get.to(() => HandymanHomePageScreen());
                }
              }
            },
            child: const Text("Sign in", style: TextStyle(color: Colors.white)),
          ),
        ),
        SizedBox(
          height: getHeight(12),
        ),
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Get.to(SignupScreen());
            },
            child: const Text(
              "Don't have account? Create new",
              style: TextStyle(
                color: Color(0xffff511a),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}