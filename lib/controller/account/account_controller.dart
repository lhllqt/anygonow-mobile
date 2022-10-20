import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/model/custom_dio.dart';

class AccountController extends GetxController{
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController business = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController country = TextEditingController();

  GlobalController globalController = Get.put(GlobalController());

  RxBool isEditting = false.obs;
  RxBool isLoading = false.obs;

  Future getUserInfo() async {
    try {
      AccountController myAccountController = Get.put(AccountController());

      var userID = globalController.user.value.id.toString();
      var response;
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();
      response = await customDio.get("/users/$userID");
      var json = jsonDecode(response.toString());
      var userInfo = json["data"]["user"];

      myAccountController.email.text = userInfo["mail"] ?? "";
      myAccountController.firstName.text = userInfo["firstName"] ?? "";
      myAccountController.lastName.text = userInfo["lastName"] ?? "";
      myAccountController.phoneNumber.text = userInfo["phone"] ?? "";

      return (json["data"]);
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }

  Future editUserInfo (
      {
        required String firstName,
        required String lastName,
        required String avatar}) async {
    try {
      AccountController myAccountController = Get.put(AccountController());
      var userID = globalController.user.value.id.toString();
      var response;
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();
      response = await customDio.put(
        "/users/$userID",
        {
          "data": {
            "UserId": userID,
            "avatarUrl": avatar,
            "firstName": firstName,
            "lastName": lastName,
          }
        },
      );
      print(response);
      var json = jsonDecode(response.toString());
      if (json["data"] != null) {
        var data = json["data"];
        return data["user"];
      } else {
        return null;
      }
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }

  Future editBusinessInfo () async {
    try {
      var userID = globalController.user.value.id.toString();
      isLoading.value = true;
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] = globalController.user.value.certificate.toString();
      var response = await customDio.put(
        "/businesses/$userID",
        {
          "data": {
            "UserId": userID,
            "avatarUrl": null,
            "name": business.text,
            "description": description.text,
          }
        },
      );
      print(response);
      var json = jsonDecode(response.toString());
      return json["data"];
    } catch (e, s) {
      print(e);
      return null;
    }
  }

  Future editBusinessContact () async {
    try {
      var userID = globalController.user.value.id.toString();
      isLoading.value = true;
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] = globalController.user.value.certificate.toString();
      var response = await customDio.put(
        "/contacts/$userID",
        {
          "data": {
            "id": userID,
            "avatarUrl": null,
            "address1": address1.text,
            "address2": address2.text,
            "stateId": state.text,
            "city": city.text,
            "zipcode": zipcode.text,
          }
        },
      );
      print(response);
      var json = jsonDecode(response.toString());
      return json["data"];
    } catch (e, s) {
      print(e);
      return null;
    }
  }



}