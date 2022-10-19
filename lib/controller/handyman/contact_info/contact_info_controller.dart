import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactInfoController extends GetxController {
  TextEditingController phone = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController county = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController website = TextEditingController();

  RxBool isEditing = false.obs;
}