import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grabsmartly/src/common_widgets/form/form_header_widget.dart';
import 'package:grabsmartly/src/features/auth/screen/forgot_password/forgot_password_otp/otp_screen.dart';
import 'package:grabsmartly/src/strings/string_images.dart';
import 'package:grabsmartly/src/strings/string_size.dart';
import 'package:grabsmartly/src/strings/string_text.dart';

class ForgetPasswordMail extends StatelessWidget{
  const ForgetPasswordMail({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child:  Column(
              children: [
                const SizedBox(height: tDefaultSize * 4,),
                const FormHeaderWidget(
                    image: (tForgotPasswordImg),
                    title: tForgetPassword,
                    subTitle: tResetViaEmail,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    heightBetween: 30.0,
                    textAlign: TextAlign.center,
                ),
                const SizedBox(height: tFormHeight,),
                Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text(tEmail),
                            hintText: (tEmail),
                            prefixIcon: Icon(Icons.mail_outline_rounded),
                          ),
                        ),
                        const SizedBox(height: 20.0,),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: (){
                                Get.to(() => OTPScreen());
                              },
                              child: const Text(tNext),
                            )
                        )

                      ],
                    ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

}