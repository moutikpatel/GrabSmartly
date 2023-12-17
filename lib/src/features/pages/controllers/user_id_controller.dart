import 'package:get/get.dart';

class UserIdController extends GetxController {
  RxString userId = ''.obs;

  void setUserId(String id) {
    userId.value = id;
  }
}
