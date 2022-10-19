import 'package:flutter/cupertino.dart';
import 'package:untitled/utils/config.dart';

Container bottomContainerLayout({required Widget child, double? height}) {
  return Container(
    margin: EdgeInsets.only(
      bottom: getHeight(46),
      left: getWidth(16),
      right: getWidth(16),
    ),
    height: getHeight(height ?? 48),
    width: double.infinity,
    child: child,
  );
}
