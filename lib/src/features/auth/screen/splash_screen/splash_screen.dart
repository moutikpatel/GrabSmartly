import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grabsmartly/src/features/auth/controllers/splash_screen_controller.dart';
import 'package:grabsmartly/src/strings/string_size.dart';
import 'package:grabsmartly/src/strings/string_text.dart';
import '../../../../strings/string_images.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final splashController = Get.put(SplashScreenController());
  //SplashScreenController splashScreenController = SplashScreenController();

  @override
  Widget build(BuildContext context) {
    splashController.startAnimation();
    return Scaffold(
        body: Stack(
          children: [
            //Orange_Blob
            Obx(() => AnimatedPositioned(
                duration: const Duration(microseconds: 1600),
                top: splashController.animate.value ? -60 : -10,
                left: splashController.animate.value ? -85 : -100,
                child: const Image(
                  image: AssetImage(tBlobImage1),height: 460,width: 460,
                )
            )),
            // App Name and Logo
            Obx(() => AnimatedPositioned(
                duration: const Duration(microseconds: 1600),
                top: 80,
                left: splashController.animate.value ? tDefaultSize : -80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tAppName, style: Theme.of(context).textTheme.titleLarge,),
                    const SizedBox(height: 10),
                    Text(tAppTagLine, style: Theme.of(context).textTheme.displayMedium,),
                  ],
                )
            )),
            // App Vector Image
            Obx(() => AnimatedPositioned(
                duration: const Duration(microseconds: 1600),
                bottom: splashController.animate.value ? 40: 0,
                child: const Image(
                  image: AssetImage(tSplashVector),height: 400,width: 400,
                )
            )),
            //Orange_Blob
            Obx(() => AnimatedPositioned(
                duration: const Duration(microseconds: 1600),
                bottom: splashController.animate.value ? 70 : -10,
                right: splashController.animate.value ? 20 : -10,
                child: const Image(
                  image: AssetImage(tBlobImage2,),height: 400,width: 400,alignment: Alignment(10, 20),
                )
            )),
          ],


        )

    );
  }
}

