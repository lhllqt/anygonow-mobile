import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/config.dart';

class CustomDialog {
  BuildContext context;
  String type;
  CustomDialog(this.context, this.type);
  void show() {
    AlertDialog alert;
    if (type == "SUCCESS") {
      alert = alertDialog(context);
    } else {
      alert = alertDialog(context);
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

AlertDialog alertDialog(context) {
  return AlertDialog(
    content: Container(
      width: getWidth(343),
      height: getHeight(253),
      child: Column(
        children: [
          SvgPicture.asset("assets/images/contact-icon.svg"),
          SizedBox(
            height: getHeight(27),
          ),
          Text(
            "このコンタクトを削除してもよろしいでしょうか。",
            style: TextStyle(fontSize: getWidth(17)),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: getHeight(12),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFFE9E9E9),
                        side: const BorderSide(
                          color: Color(0xFFE9E9E9),
                        ),
                        padding: EdgeInsets.symmetric(vertical: getHeight(12)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'cancel'.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: getWidth(17),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(width: getWidth(10)),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
