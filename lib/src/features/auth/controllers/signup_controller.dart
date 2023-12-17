import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grabsmartly/src/features/auth/models/user_data_model.dart';
import 'package:grabsmartly/src/features/pages/screen/main_nav_screen.dart';
import 'package:grabsmartly/src/repository/authentication/authentication_repository.dart';
import 'package:grabsmartly/src/repository/user_repository/user_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final confirmPassword = TextEditingController();

  /* -- Get USER Repository -- */
  final userRepository = Get.put(UserRepository());

  /* -- Register User -- */
  void registerUser(String email, String password) {
    String? error = AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password) as String;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    }
  }

  // /* -- Register User -- */
  // Future<Object?> registerUser(String email, String password) async {
  //   try {
  //     // Check if a user with the same email already exists
  //     var existingUser = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
  //     if (existingUser != null && existingUser.isNotEmpty) {
  //       // If a user with the same email exists, return an error message
  //       return Get.snackbar( 'Error','Email already in use. Please use a different email.');
  //     }
  //
  //     // If the email is not in use, create a new user
  //     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //
  //     // If user creation is successful, return the user's UID
  //     return userCredential.user?.uid;
  //   } on FirebaseAuthException catch (e) {
  //     // Handle specific firebase errors
  //     return e.message;
  //   } catch (e) {
  //     // Handle any other errors
  //     return e.toString();
  //   }
  // }

  Future<Object?> createUserData(UserDataModel user) async {
    // await userRepository.createUser(user);
    // registerUser(user.email, user.password);
    // Get.to(() => MainNavScreen());

    try {
      // Check if a user with the same email already exists
      var existingUser = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(email.text.trim());

      if (existingUser != null && existingUser.isNotEmpty) {
        // If a user with the same email exists, return an error message
        // return Get.snackbar('Error', 'Email already in use. Please use a different email.');
        //
        () => Get.snackbar(
            "Error",
            "User with the same mail exists. Please Login to Continue.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red
        );
      }

      // If the email is not in use, create a new user
      await userRepository.createUser(user);
      //registerUser(user.email, user.password);

      // If user creation is successful, return the user's UID
      return Get.to(() => const MainNavScreen());
    } on FirebaseAuthException catch (e) {
      // Handle specific firebase errors
      return Get.snackbar('Error', e.message as String);
    } catch (e) {
      // Handle any other errors
      return Get.snackbar('Error', e.toString());
    }
  }
// phoneAuthentication(user.phoneNo);
// Get.to(() => const OTPScreen());
}

void phoneAuthentication(String phoneNo) {
  AuthenticationRepository.instance.phoneAuthentication(phoneNo);
}
