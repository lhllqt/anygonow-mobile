import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/signup/signup_controller.dart';
import 'package:untitled/screen/login/login_screen.dart';
import 'package:untitled/screen/signup/check_email_screen.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/input.dart';
import 'package:untitled/widgets/app_name.dart';

class SignupScreen extends StatelessWidget {
  SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(top: getHeight(12)),
          child: confirmButtonContainer(context, signupController)),
      body: Container(
        margin: EdgeInsets.only(
          left: getWidth(16),
          right: getWidth(16),
          top: getHeight(24),
        ),
        child: ListView(
          children: [
            getAppName(),
            SizedBox(
              height: getHeight(24),
            ),
            Text(
              "Sign up",
              style: TextStyle(
                fontSize: getWidth(20),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getHeight(16),
            ),
            inputRegular(
              context,
              label: "email".tr,
              hintText: "name@email.com",
              textEditingController: signupController.email,
            ),
            SizedBox(
              height: getHeight(12),
            ),
            inputRegular(
              context,
              label: "phone".tr,
              hintText: "Enter your phone",
              textEditingController: signupController.phoneNumber,
            ),
            SizedBox(
              height: getHeight(12),
            ),
            inputRegular(
              context,
              label: "zipcode".tr,
              hintText: "Enter your zipcode",
              textEditingController: signupController.zipCode,
            ),
            SizedBox(
              height: getHeight(12),
            ),
            Obx(() => inputPassword(
                  context,
                  label: "password".tr,
                  controller: signupController.password,
                  hintText: "Enter your password",
                  isHide: signupController.isHidePassword.value,
                  changeHide: signupController.changeHidePassword,
                )),
            SizedBox(
              height: getHeight(12),
            ),
            Obx(() => inputPassword(
                  context,
                  label: "cfPassword".tr,
                  controller: signupController.confirmPassword,
                  hintText: "Enter your password",
                  isHide: signupController.isHideCfPassword.value,
                  changeHide: signupController.changeHideCfPassword,
                )),
            SizedBox(
              height: getHeight(15),
            ),
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
    BuildContext context, SignupController signupController) {
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
              if (signupController.email.text != "" &&
                  signupController.phoneNumber.text != "" &&
                  signupController.zipCode.text != "" &&
                  signupController.password.text != "" &&
                  signupController.confirmPassword.text != "") {
                var result = await signupController.signup();
                Get.to(() => CheckEmailScreen());
              }
            },
            child: Text("continue".tr, style: const TextStyle(color: Colors.white)),
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
              Get.to(() => LoginScreen());
            },
            child: const Text(
              "Already have account? Back to Sign-in",
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
