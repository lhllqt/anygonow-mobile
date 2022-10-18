import 'package:get/get.dart';
import 'package:untitled/screen/login/login_screen.dart';

class LoginPageController extends GetxController {
  Rx<LoginOption> loginOption = LoginOption.customer.obs;
}