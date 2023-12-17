import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grabsmartly/src/features/auth/screen/login_screen/login_screen.dart';
import 'package:grabsmartly/src/features/auth/screen/signup_screen/signup_screen.dart';
import 'package:grabsmartly/src/strings/string_images.dart';
import 'package:grabsmartly/src/strings/string_text.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode ? const Color(0xFF576F72) : const Color(0xFF73A9AD),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: const AssetImage(tWelcomePageImage), height: height * 0.6,),

            Column(
              children: [
                Text(
                  tWelcomeTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  tWelcomeSubTitle,
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            Row(
              children: [
                const SizedBox(width: 30),
                Expanded(
                    child: OutlinedButton(
                        onPressed: () => Get.to(() => LoginScreen()),
                        child: Text(tLoginText.toUpperCase()),
                    )
                ),

                const SizedBox(width: 10),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () => Get.to(() =>  SignUpScreen()),
                        child: Text(tSignUpText.toUpperCase())
                    )
                ),
                const SizedBox(width: 30),
              ],
            )
          ],
        ),

      ),
    );
  }

}