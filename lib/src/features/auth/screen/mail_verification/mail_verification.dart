import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grabsmartly/src/features/auth/controllers/mail_verification_controller.dart';
import 'package:grabsmartly/src/strings/string_size.dart';
import 'package:grabsmartly/src/strings/string_text.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../repository/authentication/authentication_repository.dart';


class MailVerification extends StatelessWidget{
  const MailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MailVerificationController());
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(LineAwesomeIcons.envelope_open, size: 100,),
              const SizedBox(height: 30.0,),
              Text(tOTP,style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 80.0,),
              ),
              Text(tOTPSubTitle.toUpperCase(), style: Theme.of(context).textTheme.titleSmall,),
              const SizedBox(height: 30.0,),
              TextButton(
                  onPressed: () => controller.manuallyCheckEmailVerificationStatus(),
                  child: const Text("Continue"),
              ),
              const SizedBox(height: 30.0,),
              TextButton(
                onPressed: () => controller.sendVerificationMail(),
                child: const Text("Resend Email Verification Link"),
              ),
              TextButton(
                  onPressed: () {
                    AuthenticationRepository.instance.logout();

                  }, child: const Text("Logout",style: TextStyle(color: Colors.red),),
              ),
            ],
          ),
        ),
      ),
    );
  }

}