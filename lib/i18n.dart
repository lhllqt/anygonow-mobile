import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'login': 'Login',
          'welcomeBack': "Welcome back",
          'appName': "Anygonow",
          'email_or_phone': "Email address or phone number",
          'password': "Password",
          'email': "Email address",
          "phone": "Phone",
          "zipcode": "Zipcode",
          "cfPassword": "Confirm password",
          'continue': "Continue",
          "signinNow": "Sign-in now",
          "signin": "Sign in",
          "invalid_username": "Your email address or phone number is invalid !",
          "invalid_password": "Your password is invalid !",
          "error_server": "Server is not working !",
          "close": "Close",
          "confirm": "Confirm",
          "success_add_payment": "Successfully added new payment method !",
          "common_success": "Successfully !"
        },
      };
}
