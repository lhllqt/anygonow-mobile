import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/forgot_password/forgot_password_controller.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_name.dart';
import 'package:untitled/widgets/bounce_button.dart';
import 'package:untitled/widgets/input.dart';

class CheckEmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(top: getHeight(12)),
          child: confirmButtonContainer(context)),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF454B52),
            ),
            onPressed: () {
              Get.back();
            }),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(
          left: getWidth(24),
          right: getWidth(24),
          top: getHeight(24),
        ),
        child: Column(
          children: [
            getAppName(),
            SizedBox(
              height: getHeight(38),
            ),
            Container(
              height: getHeight(120),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icons/mail_sending.png'),
                ),
              ),
            ),
            SizedBox(
              height: getHeight(36),
            ),
            Text(
              "Please check your email",
              style: TextStyle(
                  fontSize: getWidth(24),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFFF511A)),
            ),
            SizedBox(
              height: getHeight(16),
            ),
            Text(
              "Confirmation link has been sent to email address ******291@gmail.com.",
              style: TextStyle(
                fontSize: getWidth(13),
                height: getHeight(2),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: getHeight(36)),
              width: getWidth(98),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color(0xFFE6E6E6),
                  ),
                ),
              ),
            ),
            Text(
              "No email? Check your spam folder before you ",
              style: TextStyle(
                fontSize: getWidth(13),
                height: getHeight(2),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getHeight(12),
            ),
            Bouncing(
                child: const Text(
                  "Resend the link.",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF3864FF),
                  ),
                  textAlign: TextAlign.center,
                ),
                onPress: () => {}),
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
    height: getHeight(48),
    width: double.infinity,
    child: child,
  );
}

Container confirmButtonContainer(BuildContext context) {
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
            onPressed: () async {},
            child: Text("continue".tr,
                style: const TextStyle(color: Colors.white)),
          ),
        ),
      ],
    ),
  );
}