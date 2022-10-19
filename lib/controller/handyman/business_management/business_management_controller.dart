import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BusinessManagementController extends GetxController {
  RxBool isBusinessScreen = true.obs;
  TextEditingController name = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();

  RxBool isEditing = false.obs;
}