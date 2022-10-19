import 'dart:convert';

import 'package:get/get.dart';
import 'package:untitled/model/custom_dio.dart';

import '../../global_controller.dart';

class PaymentController extends GetxController {
  GlobalController globalController = Get.put(GlobalController());

  var cardNumber = "".obs;
  var cardExpireDate = "".obs;
  var cardCVV = "".obs;
  var cardHolder = "".obs;

  var paymentMethod = {}.obs;

  Future getPaymentMethods() async {
    try {
      CustomDio customDio = CustomDio();
      var response = await customDio.get("businesses/payment-method");
      var json = jsonDecode(response.toString());
      var payment = json["data"]["payment"];
      paymentMethod.value = payment;
      return response;
    } catch (e, s) {
      return null;
    }
  }
}