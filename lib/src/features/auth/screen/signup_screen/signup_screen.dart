
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grabsmartly/src/common_widgets/form/form_header_widget.dart';
import 'package:grabsmartly/src/features/auth/screen/login_screen/login_screen.dart';
import 'package:grabsmartly/src/features/auth/screen/signup_screen/signup_form_widget.dart';
import 'package:grabsmartly/src/repository/authentication/authentication_repository.dart';
import 'package:grabsmartly/src/strings/string_images.dart';
import 'package:grabsmartly/src/strings/string_size.dart';
import 'package:grabsmartly/src/strings/string_text.dart';
import 'package:grabsmartly/src/strings/string_colors.dart';

class SignUpScreen extends StatelessWidget{
   SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child:  Column(
              children: [
                const FormHeaderWidget(image: tWelcomePageImage, title: tSignUpTitle, subTitle: tSignUpSubTitle),
                SignUpFormWidget(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("OR"),
                    SizedBox(height: tFormHeight - 10.0,),

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
                        onPressed: () => Get.to(() => LoginScreen()),
                        child: Text.rich(
                            TextSpan(text:tAlreadyHaveAccount,
                                style: Theme.of(context).textTheme.bodySmall,
                                children: const[
                                  TextSpan(
                                    text: tLoginText,
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

