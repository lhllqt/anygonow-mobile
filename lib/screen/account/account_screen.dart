import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/account/account_controller.dart';
import 'package:untitled/controller/global_controller.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_bar.dart';
import 'package:untitled/widgets/dialog.dart';
import 'package:untitled/widgets/dropdown.dart';
import 'package:untitled/widgets/image.dart';
import 'package:untitled/widgets/input.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AccountController accountController = Get.put(AccountController());
  GlobalController globalController = Get.put(GlobalController());
  File logoFile = File("");

  @override
  Widget build(BuildContext context) {
    accountController.getUserInfo();
    return Scaffold(
      appBar: appBar(title: "Profile", actions: [
        GestureDetector(
          onTap: () async {
            if (accountController.isEditting.value) {
              accountController.isLoading.value = true;
              if (logoFile.path != "") {
                var contentLength = await logoFile.length();
                var filename = logoFile.path.split("/").last;
                var logoUrl = await ImageService.handleUploadImage(
                    filename, contentLength, logoFile);
                accountController.logoImage.value = logoUrl;
              }
              var result = await accountController.editUserInfo();
              if (result != null) {
                accountController.isEditting.value =
                    !accountController.isEditting.value;
                CustomDialog(context, "SUCCESS")
                    .show({"message": "Update information successfully"});
              }
              return;
            }
            accountController.isEditting.value =
                !accountController.isEditting.value;
          },
          child: Obx(
            () => Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: getHeight(16)),
                child: Text(
                  accountController.isEditting.value
                      ? "Update"
                      : "Edit information",
                  style: TextStyle(
                      color: const Color(0xFF3864FF),
                      fontSize: getHeight(14),
                      decoration: TextDecoration.underline),
                )),
          ),
        ),
      ]),
      body: Container(
        padding: EdgeInsets.only(
          left: getWidth(27),
          right: getWidth(27),
        ),
        child: ListView(
          children: [
            SizedBox(
              height: getHeight(20),
            ),
            Text(
              "Personal Information",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: getHeight(18),
                  color: Colors.black),
            ),
            SizedBox(
              height: getHeight(16),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: logoFile.path == "" &&
                      accountController.logoImage.value == ""
                  ? GestureDetector(
                      onTap: () async {
                        if (!accountController.isEditting.value) {
                          return;
                        }
                        XFile? pickedFile = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                          maxWidth: 1800,
                          maxHeight: 1800,
                        );
                        if (pickedFile != null) {
                          setState(() {
                            logoFile = File(pickedFile.path);
                          });
                        }
                      },
                      child: SvgPicture.asset(
                        "assets/icons/account.svg",
                      ),
                    )
                  : Obx(() => Align(
                        alignment: Alignment.centerLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(56),
                          child: Container(
                              width: getHeight(60),
                              height: getHeight(60),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: accountController.logoImage.value != ""
                                      ? Colors.blueGrey
                                      : Colors.transparent),
                              child: logoFile.path != ""
                                  ? Image.file(
                                      logoFile,
                                      fit: BoxFit.cover,
                                    )
                                  : getImage(accountController.logoImage.value,
                                      width: getWidth(60),
                                      height: getHeight(60))),
                        ),
                      )),
            ),
            SizedBox(
              height: getHeight(16),
            ),
            Obx(() => inputRegular(
                  context,
                  label: "First name",
                  hintText: "",
                  textEditingController: accountController.firstName,
                  enabled: accountController.isEditting.value,
                  required: true,
                )),
            SizedBox(
              height: getHeight(16),
            ),
            Obx(() => inputRegular(
                  context,
                  label: "Last name",
                  hintText: "",
                  textEditingController: accountController.lastName,
                  enabled: accountController.isEditting.value,
                  required: true,
                )),
            SizedBox(
              height: getHeight(16),
            ),
            Obx(() => inputRegular(
                  context,
                  label: "Email Address",
                  hintText: "",
                  textEditingController: accountController.email,
                  enabled: accountController.isEditting.value,
                  required: true,
                )),
            SizedBox(
              height: getHeight(16),
            ),
            Obx(() => inputRegular(
                  context,
                  label: "Phone number",
                  hintText: "",
                  textEditingController: accountController.phoneNumber,
                  required: true,
                  enabled: accountController.isEditting.value,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                )),
            SizedBox(
              height: getHeight(24),
            ),
            Text(
              "Contact Information",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: getHeight(18),
                  color: Colors.black),
            ),
            SizedBox(
              height: getHeight(16),
            ),
            Obx(() => inputRegular(
                  context,
                  label: "Address 1",
                  hintText: "",
                  textEditingController: accountController.address1,
                  enabled: accountController.isEditting.value,
                  required: true,
                )),
            SizedBox(
              height: getHeight(16),
            ),
            Obx(() => inputRegular(
                  context,
                  label: "Address 2",
                  hintText: "",
                  textEditingController: accountController.address2,
                  enabled: accountController.isEditting.value,
                )),
            SizedBox(
              height: getHeight(16),
            ),
            Stack(children: [
              Obx(
                () => inputRegular(
                  context,
                  label: "State",
                  hintText: "",
                  textEditingController: accountController.state,
                  enabled: accountController.isEditting.value,
                  required: true,
                ),
              ),
              Obx(() => accountController.isEditting.value
                  ? Container(
                      child: getDropDown(
                        globalController.states
                            .map((e) => e.name ?? "")
                            .toList(),
                        (String value) =>
                            {accountController.state.text = value},
                      ),
                      margin: EdgeInsets.only(top: getHeight(22)),
                    )
                  : Container()),
            ]),
            SizedBox(
              height: getHeight(15),
            ),
            Obx(() => inputRegular(
                  context,
                  hintText: "",
                  label: "City",
                  textEditingController: accountController.city,
                  enabled: accountController.isEditting.value,
                  required: true,
                )),
            SizedBox(
              height: getHeight(8),
            ),
            Obx(() => inputRegular(
                  context,
                  label: "Zipcode",
                  hintText: "",
                  textEditingController: accountController.zipcode,
                  enabled: accountController.isEditting.value,
                  required: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                )),
            SizedBox(
              height: getHeight(16),
            ),
          ],
        ),
      ),
    );
  }
}
