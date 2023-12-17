import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grabsmartly/src/features/auth/screen/signup_screen/signup_screen.dart';
import 'package:grabsmartly/src/strings/string_images.dart';
import 'package:grabsmartly/src/strings/string_size.dart';
import 'package:grabsmartly/src/strings/string_text.dart';
import '../../../../common_widgets/form/form_header_widget.dart';
import '../../../../repository/authentication/authentication_repository.dart';
import 'login_form_widget.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size =  MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FormHeaderWidget(image: tWelcomePageImage, title: tLoginTitle, subTitle: tLoginSubTitle),
                LoginFormWidget(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("OR"),
                    const SizedBox(height: tFormHeight - 10.0,),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => AuthenticationRepository().signInWithGoogle()  ,
                            icon: const Image(image: AssetImage(tGoogleLogoImage), height: 60, width: 60,),
                          ),
                          IconButton(
                            onPressed: () {  },
                            icon: const Image(image: AssetImage(tFacebookLogoImage),height: 60, width: 60,),
                          ),
                        ],
                    ),
                    const SizedBox(height: tFormHeight - 20.0,),
                    TextButton(
                        onPressed: () =>  Get.to(() =>  SignUpScreen()),
                        child: Text.rich(
                          TextSpan(text:tDontHaveAccount,
                          style: Theme.of(context).textTheme.bodySmall,
                          children: const[
                            TextSpan(
                              text: tSignUpText,
                              style: TextStyle(color: Colors.blue),
                            )

                          ])
                        ))
                  ],
                )
              ],
            ),
          ),

        ),
      ),
    );
  }

}
