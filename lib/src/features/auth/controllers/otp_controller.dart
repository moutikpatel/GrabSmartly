// ignore_for_file: unused_import

import 'package:get/get.dart';
import 'package:grabsmartly/src/features/auth/screen/splash_screen/splash_screen.dart';
import 'package:grabsmartly/src/features/pages/screen/grocery_list/grocery_list_screen.dart';
import 'package:grabsmartly/src/features/pages/screen/main_nav_screen.dart';

import '../../../repository/authentication/authentication_repository.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async{
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(MainNavScreen()) : Get.back();
  }


}