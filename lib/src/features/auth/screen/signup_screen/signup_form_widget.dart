import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grabsmartly/src/features/auth/controllers/signup_controller.dart';
import 'package:grabsmartly/src/features/auth/models/user_data_model.dart';
import '../../../../strings/string_size.dart';
import '../../../../strings/string_text.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {

  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    final nameController = controller.fullName;
    final emailController = controller.email;
    final phoneNoController = controller.phoneNo;
    final passwordController = controller.password;
    final confirmPasswordController = controller.confirmPassword;
    //bool passwordVisibile = true;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //FullName
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                  label: Text(tFullName),
                  prefixIcon: Icon(Icons.person_outline_rounded)
              ),
              validator: (fullName){
                if(fullName == null || fullName.isEmpty){
                  return 'Enter your Name here.';
                }
                else if (fullName.length < 3 || fullName.length > 79){
                  return 'Name should be between 3 to 80 characters long.';
                }
                else if (!fullName.isAlphabetOnly){
                  return 'Alphabets only!';
                }
                else {
                  return null;
                }
              },
            ),
            const SizedBox(height: tFormHeight - 20.0,),
            //Email
            TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    label: Text(tEmail),
                    prefixIcon: Icon(Icons.email_outlined)
                ),
              validator: (email){
                if(email == null || email.isEmpty){
                  return 'Enter your Email here.';
                }
                else if (!email.isEmail){
                  return 'Invalid Email format. Please try again.';
                }
                else {
                  return null;
                }
              },
            ),
            const SizedBox(height: tFormHeight - 20.0,),
            //PhoneNumber
            TextFormField(
              controller: phoneNoController,
              decoration: const InputDecoration(
                  label: Text(tPhoneNumber),
                  prefixIcon: Icon(Icons.numbers)
              ),
              validator: (phone){
                if(phone == null || phone.isEmpty){
                  return 'Enter your Phone Number here.';
                }
                else if (!phone.isPhoneNumber){
                  return 'Invalid Phone Number. Please try again.';
                }
                else {
                  return null;
                }
              },
            ),
            const SizedBox(height: tFormHeight - 20.0,),
            //Password
            TextFormField(
                controller: passwordController,
                obscureText: passwordVisible,
                decoration:  InputDecoration(
                    label: const Text(tPassword),
                    prefixIcon: const Icon(Icons.fingerprint_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                  ),
                ),
                validator: (password) {
                  if (password == null || password.isEmpty){
                    return 'Enter your Password here.';
                  }
                  else if (password.length < 8  || password.length > 10){
                    return 'Password should be between 3 to 80 characters long.';
                  }
                  else if (password.isAlphabetOnly){
                    return 'Password should include special characters';
                  }
                  return null;
                },
            ),
            const SizedBox(height: tFormHeight - 20.0,),
            //Confirm password
            TextFormField(
              controller: confirmPasswordController,
              obscureText: confirmPasswordVisible,
              decoration:  InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint_outlined),
                //labelText: tPassword,
                hintText: 'Confirm $tPassword',
                suffixIcon: IconButton(
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      confirmPasswordVisible = !confirmPasswordVisible;
                    });
                  },
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    confirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),

                )
              ),
              validator: (confirmPassword) {
                if (confirmPassword != passwordController.text){
                  return 'Password does not match. Please Try again';
                }
                return null;
              },

            ),
            const SizedBox(height: tFormHeight - 10.0,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      final user = UserDataModel(
                          fullName: controller.fullName.text.trim(),
                          email: controller.email.text.trim(),
                          phoneNo: controller.phoneNo.text.trim(),
                          password: controller.password.text.trim());


                      SignUpController.instance.
                      createUserData(user);
                      //Get.to(() => const OTPScreen());
                    }
                  },
                  child: Text(tSignUpText.toUpperCase())
              ),
            )
          ],
        ),
      ),
    );
  }
}