import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grabsmartly/src/features/auth/screen/forgot_password/forgot_password_mail/forget_password_mail.dart';
import 'package:grabsmartly/src/features/auth/screen/forgot_password/forgot_password_phone/forgot_password_phone.dart';
import 'package:grabsmartly/src/repository/authentication/authentication_repository.dart';
import '../../../../strings/string_size.dart';
import '../../../../strings/string_text.dart';
import '../forgot_password/forgot_password_options/forget_password_button_widget.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    Key? key,
  });

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: tFormHeight - 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User email
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                hintText: tEmail,
              ),
              controller: emailController,
              validator: (email) {
                if (email == null || email.isEmpty) {
                  return 'Enter your Email here.';
                } else if (!email.isEmail) {
                  return 'Invalid Email format. Please try again.';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: tFormHeight - 20.0),
            // User password
            TextFormField(
              controller: passwordController,
              obscureText: passwordVisible,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint_outlined),
                hintText: tPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
              ),
              validator: (password) {
                if (password == null || password.isEmpty) {
                  return 'Enter your Password here.';
                } else if (password.length < 8 || password.length > 10) {
                  return 'Password should be between 3 to 80 characters long.';
                } else if (password.isAlphabetOnly) {
                  return 'Password should include special characters';
                }
                return null;
              },
            ),
            // Confirm password
            TextFormField(
              controller: confirmPasswordController,
              obscureText: confirmPasswordVisible,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint_outlined),
                hintText: 'Confirm $tPassword',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      confirmPasswordVisible = !confirmPasswordVisible;
                    });
                  },
                  icon: Icon(
                    confirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ),
              validator: (confirmPassword) {
                if (confirmPassword != passwordController.text) {
                  return 'Password does not match. Please Try again';
                }
                return null;
              },
            ),
            const SizedBox(height: tFormHeight - 20.0),
            // Forget Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    builder: (context) => Container(
                      padding: const EdgeInsets.all(tDefaultSize),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tForgetPassword,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            tForgetPasswordSubTitle,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 10.0),
                          ForgetPasswordButtonWidget(
                            btnIcon: Icons.mail_outline_rounded,
                            title: tEmail,
                            subTitle: tResetViaEmail,
                            onClick: () {
                              Navigator.pop(context);
                              Get.to(() => const ForgetPasswordMail());
                            },
                          ),
                          const SizedBox(height: 10.0),
                          ForgetPasswordButtonWidget(
                            btnIcon: Icons.mobile_friendly_rounded,
                            title: tPhoneNumber,
                            subTitle: tResetViaPhone,
                            onClick: () {
                              Navigator.pop(context);
                              Get.to(() => const ForgetPasswordPhone());
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: const Text(tForgetPassword),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => AuthenticationRepository().signInWithCredentials(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                ),
                child: Text(tLoginText.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
