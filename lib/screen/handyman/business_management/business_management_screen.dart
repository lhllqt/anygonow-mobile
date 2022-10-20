import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/account/account_controller.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/app_bar.dart';
import 'package:untitled/widgets/bounce_button.dart';
import 'package:untitled/widgets/dropdown.dart';
import 'package:untitled/widgets/image.dart';
import 'package:untitled/widgets/input.dart';
import 'package:untitled/widgets/layout.dart';
import 'package:us_states/us_states.dart';

class BusinessManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountController accountController = Get.put(AccountController());
    accountController.getBusinessInfo();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar(title: "Manage your business"),
      bottomNavigationBar: Padding(padding: EdgeInsets.only(top: getHeight(0)), child: confirmButtonContainer(context, accountController)),
      body: ListView(
        padding: EdgeInsets.only(
          left: getWidth(33),
        ),
        children: [
          Row(
            children: [
              Bouncing(
                child: Obx(() {
                  return Container(
                    height: getHeight(36),
                    width: getWidth(97),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: accountController.isBusinessScreen.value ? Color(0xFFC4C4C4) : Color(0xFFFFFFFF),
                    ),
                    child: const Text("Service info"),
                  );
                }),
                onPress: () => {
                  if (!accountController.isBusinessScreen.value) {accountController.isBusinessScreen.value = true}
                },
              ),
              SizedBox(
                width: getWidth(11),
              ),
              Bouncing(
                child: Obx(() {
                  return Container(
                    height: getHeight(36),
                    width: getWidth(97),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.black,
                        ),
                        color: accountController.isBusinessScreen.value ? Color(0xFFFFFFFF) : Color(0xFFC4C4C4)),
                    child: Text("Contact info"),
                  );
                }),
                onPress: () => {
                  if (accountController.isBusinessScreen.value) {accountController.isBusinessScreen.value = false}
                },
              ),
            ],
          ),
          SizedBox(
            height: getHeight(15),
          ),
          Obx(
            () => accountController.isBusinessScreen.value
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getHeight(20),
                      ),
                      Text(
                        "Logo images*",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: getWidth(12),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(8),
                      ),
                      Text(
                        "This image will also be used for navigation. At least 210x210 recommended.",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: getWidth(10), color: const Color(0xFF696969)),
                      ),
                      SizedBox(
                        height: getHeight(10),
                      ),
                      Obx(() => Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(56),
                              child: Container(
                                  width: getHeight(60),
                                  height: getHeight(60),
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: accountController.logoImage.value != "" ? Colors.blueGrey : Colors.transparent),
                                  child: getImage(accountController.logoImage.value, width: getWidth(60), height: getHeight(60))),
                            )),
                          )),
                      SizedBox(
                        height: getHeight(18),
                      ),
                      Text(
                        "Banner",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: getWidth(12),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(8),
                      ),
                      Text(
                        "This image will be used for featuring your business on the homepage. At least 440x220 recommended.",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: getWidth(10), color: const Color(0xFF696969)),
                      ),
                      SizedBox(
                        height: getHeight(10),
                      ),
                      Obx(() => Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                height: getWidth(56),
                                width: getWidth(108),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: getImage(accountController.bannerImage.value)),
                          )),
                      SizedBox(
                        height: getHeight(18),
                      ),
                      inputRegular(
                        context,
                        hintText: "Business name*",
                        textEditingController: accountController.business,
                        enabled: accountController.isEditting.value,
                      ),
                      SizedBox(
                        height: getHeight(18),
                      ),
                      inputRegular(
                        context,
                        hintText: "Professional Category*",
                        textEditingController: accountController.category,
                        enabled: accountController.isEditting.value,
                      ),
                      SizedBox(
                        height: getHeight(18),
                      ),
                      inputRegular(context,
                          hintText: "Description",
                          enabled: accountController.isEditting.value,
                          textEditingController: accountController.description, maxLines: 6, keyboardType: TextInputType.multiline, height: 120, minLines: 4),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      inputRegular(
                        context,
                        hintText: "Phone number*",
                        textEditingController: accountController.phoneNumber,
                        enabled: accountController.isEditting.value,
                      ),
                      SizedBox(
                        height: getHeight(8),
                      ),
                      Stack(children: [
                        inputRegular(
                          context,
                          hintText: "State*",
                          enabled: accountController.isEditting.value,
                          textEditingController: accountController.state,
                        ),
                        Obx(() => accountController.isEditting.value
                            ? getDropDown(
                                USStates.getAllNames(),
                                (String value) => {accountController.state.text = value},
                              )
                            : Container()),
                      ]),
                      SizedBox(
                        height: getHeight(8),
                      ),
                      inputRegular(
                        context,
                        hintText: "City*",
                        textEditingController: accountController.city,
                        enabled: accountController.isEditting.value,
                      ),
                      SizedBox(
                        height: getHeight(8),
                      ),
                      inputRegular(
                        context,
                        hintText: "Country",
                        textEditingController: accountController.country,
                        enabled: accountController.isEditting.value,
                      ),
                      SizedBox(
                        height: getHeight(8),
                      ),
                      inputRegular(
                        context,
                        hintText: "Address 1*",
                        textEditingController: accountController.address1,
                        enabled: accountController.isEditting.value,
                      ),
                      SizedBox(
                        height: getHeight(8),
                      ),
                      inputRegular(
                        context,
                        hintText: "Address 2",
                        textEditingController: accountController.address2,
                        enabled: accountController.isEditting.value,
                      ),
                      SizedBox(
                        height: getHeight(8),
                      ),
                      inputRegular(
                        context,
                        hintText: "Zipcode*",
                        textEditingController: accountController.zipcode,
                        enabled: accountController.isEditting.value,
                      ),
                      SizedBox(
                        height: getHeight(8),
                      ),
                      inputRegular(
                        context,
                        hintText: "Website",
                        textEditingController: accountController.website,
                        enabled: accountController.isEditting.value,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

Container confirmButtonContainer(BuildContext context, AccountController controller) {
  return bottomContainerLayout(
    height: 60,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(
          () => Expanded(
            child: controller.isLoading.value == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xffff511a),
                      side: const BorderSide(
                        color: Color(0xffff511a),
                      ),
                    ),
                    onPressed: () async {
                      if (controller.isEditting.value) {
                        var result = await controller.editBusinessInfo();
                        controller.isLoading.value = false;
                        if (result != null && controller.isBusinessScreen.value) {
                          controller.isBusinessScreen.value = false;
                        }
                      }
                      controller.isEditting.value = !controller.isEditting.value;
                    },
                    child: Text(controller.isEditting.value ? "update".tr : "edit".tr, style: const TextStyle(color: Colors.white)),
                  ),
          ),
        ),
        SizedBox(
          height: getHeight(12),
        ),
      ],
    ),
  );
}
