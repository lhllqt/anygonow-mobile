import 'package:flutter/material.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/bounce_button.dart';
import 'package:untitled/widgets/input.dart';
import 'package:untitled/widgets/app_name.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          margin: const EdgeInsets.only(
            top: 100,
            left: 48,
            right: 48,
          ),
          child: ListView(
            children: [
              getAppName(),
              SizedBox(
                height: getHeight(15),
              ),
              Text(
                "Customer - Sign up",
                style: TextStyle(
                  fontSize: getWidth(20),
                ),
              ),
              SizedBox(
                height: getHeight(10),
              ),
              Text(
                "Sign up to your account",
                style: TextStyle(
                  fontSize: getWidth(14),
                ),
              ),
              SizedBox(
                height: getHeight(12),
              ),
              inputRegular(
                context,
                hintText: "Username*",
              ),
              SizedBox(
                height: getHeight(12),
              ),
              inputRegular(
                context,
                hintText: "Email*",
              ),
              SizedBox(
                height: getHeight(12),
              ),
              inputRegular(
                context,
                hintText: "Phone Number*",
              ),
              SizedBox(
                height: getHeight(12),
              ),
              inputRegular(
                context,
                hintText: "Zipcode*",
              ),
              SizedBox(
                height: getHeight(12),
              ),
              inputPassword(
                context,
                "Password*",
              ),
              SizedBox(
                height: getHeight(15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      height: getHeight(14),
                      width: getHeight(14),
                      child: Checkbox(
                        value: false,
                        onChanged: (value) => {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      )),
                  SizedBox(
                    width: getWidth(14),
                  ),
                  Text(
                    "I agree to the Term of Use and Privacy Policy ",
                    style: TextStyle(fontSize: getWidth(12)),
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(12),
              ),
              Bouncing(
                child: Container(
                  alignment: Alignment.center,
                  height: getHeight(42),
                  width: getWidth(double.infinity),
                  decoration: BoxDecoration(
                      color: Color(0xFF000000).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Color(0xFF000000),
                        width: getWidth(1),
                      )),
                  child: Text ("Login"),
                ),
                onPress: () => {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}