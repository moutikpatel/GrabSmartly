

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grabsmartly/src/repository/authentication/authentication_repository.dart';

class MailVerificationController extends GetxController{
  late Timer _timer;
  @override
  void onInit() {
    super.onInit();
    sendVerificationMail();
    setTimerForAutoRedirect();
  }

  Future<void> sendVerificationMail() async {
    try{
      await AuthenticationRepository.instance.sendEmailVerification();
    }catch(e){}
  }
  void setTimerForAutoRedirect(){
      _timer = Timer.periodic(Duration(seconds: 180), (timer) {
        FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if(user!.emailVerified){
          timer.cancel();
          AuthenticationRepository.instance.setInitialScreen(user);
        }
      });
  }
  void manuallyCheckEmailVerificationStatus(){}
}