import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/controller/signup/signup_controller.dart';
import 'package:untitled/screen/login/login_screen.dart';
import 'package:untitled/screen/signup/check_email_screen.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/dialog.dart';
import 'package:untitled/widgets/input.dart';
import 'package:untitled/widgets/app_name.dart';
import 'package:untitled/widgets/layout.dart';
import 'package:url_launcher/url_launcher.dart';

class SignupContractScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SignupController signupController = Get.put(SignupController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(top: getHeight(0)),
          child: confirmButtonContainer(context, signupController)),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
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
              "Contractor - Sign up",
              style: TextStyle(
                fontSize: getHeight(20),
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
              required: true,
              textEditingController: signupController.email,
            ),
            SizedBox(
              height: getHeight(12),
            ),
            inputPhoneNUmber(
              context,
              label: "phone".tr,
              hintText: "Enter your phone",
              required: true,
              textEditingController: signupController.phoneNumber,
              numberOnly: true,
              maxLength: 12,
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
                  required: true,
                )),
            SizedBox(
              height: getHeight(12),
            ),
            Obx(() => inputPassword(
                  context,
                  label: "cfPassword".tr,
                  controller: signupController.confirmPassword,
                  hintText: "Enter your password",
                  required: true,
                  isHide: signupController.isHideCfPassword.value,
                  changeHide: signupController.changeHideCfPassword,
                )),
            SizedBox(
              height: getHeight(12),
            ),
            inputRegular(
              context,
              label: "referCode".tr,
              textEditingController: signupController.referral,
              hintText: "Enter referral code",
            ),
            SizedBox(
              height: getHeight(12),
            ),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                      value: signupController.isAgree.value,
                      onChanged: (bool? value) {
                        signupController.isAgree.value = value ?? false;
                      }),
                ),
                Text(
                  "I agree to the ",
                  style: TextStyle(
                      fontSize: getHeight(14), fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () async {
                    String url = GlobalController.baseWebUrl;
                    String termsUrl = url + "terms";
                    await launch(termsUrl);
                  },
                  child: Text(
                    "Term of Use",
                    style: TextStyle(
                        fontSize: getHeight(14),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF3864FF),
                        decoration: TextDecoration.underline),
                  ),
                ),
                Text(
                  " and ",
                  style: TextStyle(
                      fontSize: getHeight(14), fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () async {
                    String url = GlobalController.baseWebUrl;
                    String privacyUrl = url + "privacy";
                    await launch(privacyUrl);
                  },
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(
                        fontSize: getHeight(14),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF3864FF),
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Container confirmButtonContainer(
    BuildContext context, SignupController signupController) {
  return bottomContainerLayout(
    height: 108,
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
              // if (signupController.email.text != "" && signupController.password.text != "" && signupController.isAgree.value == true && signupController.confirmPassword.text != "") {
              //   var result = await signupController.signup();
              //   Get.to(() => CheckEmailScreen());
              // }
              bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(signupController.email.text);
              if (!emailValid) {
                CustomDialog(context, "FAILED")
                    .show({"message": "Email invalidate"});
                return;
              }
              bool phoneValid = RegExp(r'(^\+1[0-9]{3}[0-9]{3}[0-9]{4}$)')
                  .hasMatch(signupController.phoneNumber.text);
              if (!phoneValid) {
                CustomDialog(context, "FAILED").show({
                  "message": "Phone numbers must be in the format: +1AAABBBCCCC"
                });
                return;
              }
              bool passValid =
                  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                      .hasMatch(signupController.password.text);
              if (!passValid) {
                CustomDialog(context, "FAILED").show({
                  "message":
                      "Password must contain at least 8 characters, 1 uppercase, 1 lowercase and 1 number"
                });
                return;
              }
              if (signupController.password.text !=
                  signupController.confirmPassword.text) {
                CustomDialog(context, "FAILED")
                    .show({"message": "Re-entered password is incorrect"});
                return;
              }
              if (signupController.isAgree.value == false) {
                CustomDialog(context, "FAILED")
                    .show({"message": "You do not agree to the terms of use"});
                return;
              }
              var result = await signupController.signup();
              Get.to(() => CheckEmailScreen());
            },
            child: Text("continue".tr,
                style: const TextStyle(color: Colors.white)),
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
              Get.offAll(() => LoginScreen());
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
