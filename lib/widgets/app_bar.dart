import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/config.dart';

AppBar appBar({String? title}) {
  return AppBar(
    backgroundColor: Colors.white,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
        size: getHeight(20),
      ),
      onPressed: () {
        Get.back();
      },
    ),
    elevation: 0,
    title: Text(
      title ?? "",
      style: TextStyle(
        fontSize: getHeight(18),
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ),
  );
}
