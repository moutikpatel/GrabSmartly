import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grabsmartly/src/features/auth/screen/home_page/home_page.dart';
import 'package:grabsmartly/src/features/auth/screen/splash_screen/splash_screen.dart';
import 'package:grabsmartly/src/repository/authentication/exceptions/signup_email_password_failure.dart';
import 'package:grabsmartly/src/repository/authentication/exceptions/t_exceptions.dart';

import '../../features/auth/models/user_data_model.dart';
import '../../features/pages/screen/main_nav_screen.dart';
import '../../localization/user_provider.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  late final Rx<User?> fireBaseUser;
  // late final
  final _auth = FirebaseAuth.instance;
  final _phoneVerificationId = ''.obs;
  @override
  void onReady() {
    fireBaseUser = Rx<User?>(_auth.currentUser);
    fireBaseUser.bindStream(_auth.userChanges());

    FlutterNativeSplash.remove();
    setInitialScreen(fireBaseUser.value);
    //ever(fireBaseUser, _setInitialScreen);
  }

  final UserIdProvider _userIdProvider = UserIdProvider();

  // ... other code ...

  void setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => SplashScreen());
    } else {
      // Use UserIdProvider to set the user ID
      _userIdProvider.setUserId(user.uid);
      Get.offAll(() => const MainNavScreen());
    }
  }

  Future<void> phoneAuthentication(String phoneNo) async{
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async{
        await _auth.signInWithCredential(credential);
      },

      codeSent: (verificationID, resendToken) {
        _phoneVerificationId.value = verificationID;
      },
      codeAutoRetrievalTimeout: (verificationID) {
        _phoneVerificationId.value = verificationID;
      },
      verificationFailed: (e){
        if(e.code == 'invalid-phone-number'){
          Get.snackbar('Error', 'Following Phone number Invalid!');
        }else{
          Get.snackbar('Error', 'Something went wrong. Try again.');
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async{
    var credentials = await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: _phoneVerificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  // Future<String> createUserWithEmailAndPassword(String email, String password) async{
  //   try{
  //     await _auth.createUserWithEmailAndPassword(email: email, password: password);
  //     if (fireBaseUser.value != null) {
  //       Get.offAll(() => const MainNavScreen());
  //       return 'MainNavScreen';
  //     } else {
  //       Get.to(() => const HomePage());
  //       return 'HomePage';
  //     }
  //   } on FirebaseAuthException catch(e){
  //     final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
  //     print('FIREBASE AUTH EXCEPTION - ${ex.message}');
  //     throw ex;
  //
  //   } catch(_){
  //     const ex = SignUpWithEmailAndPasswordFailure();
  //     print('EXCEPTION - ${ex.message}');
  //     throw ex;
  //
  //   }
  // }
  void createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((userCredential) {
        // Create the user document in Firestore
        createUsersDocument(userCredential.user!);

        // Set the user ID if the authentication is successful
        _userIdProvider.setUserId(userCredential.user!.uid);

        Get.offAll(() => MainNavScreen());
      });
    } catch (e) {
      // Handle authentication failure
      print('Error creating user: $e');
    }
  }

  void createUsersDocument(User user) async {
    try {
      await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
        // User details
        'userId': user.uid,
        'email': user.email,
        // Add other user details as needed
      });

      print('User document created successfully');
    } catch (error) {
      print('Error creating user document: $error');
    }
  }


  Future<void> signInWithCredentials(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password),
      );
      Get.to(() => const MainNavScreen());
      // Handle successful sign-in
    } catch (e) {
      // Handle authentication failure
      print('Login failed: $e');
    }
  }
  Future<void> sendEmailVerification() async{
    try{
      await _auth.currentUser?.sendEmailVerification();
    }on FirebaseAuthException catch(e){
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch(_){
      const ex = TExceptions();
      throw ex.message;
    }
  }
  void createUserDocument(UserDataModel userData) async {
    try {
      await FirebaseFirestore.instance.collection('Users').doc(userData.id).set(userData.toJson());

      print('User document created successfully');
    } catch (error) {
      print('Error creating user document: $error');
    }
  }

  UserDataModel createUserModelFromUserCredential(UserCredential userCredential) {
    User user = userCredential.user!;
    return UserDataModel(
      fullName: user.displayName ?? '',
      email: user.email ?? '', phoneNo: '', password: '',
      // Other properties as needed
    );
  }
  // Google Sign in
  Future<UserCredential> signInWithGoogle() async {
    // Begin Sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // Check if the user canceled the Google sign-in
    if (gUser == null) {
      return Future.error("Google sign-in canceled");
    }

    // Obtain Authentication details
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    // Create new user Credential
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

// Assuming you have a method to create UserDataModel from the UserCredential
    UserDataModel userData = createUserModelFromUserCredential(userCredential);

// Now you can use `userData` as needed
    createUserDocument(userData);


// Now you can use `userData` as needed


    // Navigate to the main navigation screen
    Get.to(() => MainNavScreen());

    return userCredential;
  }


  // // Facebook Sign in
  // Future<UserCredential> signInWithFacebook() async{
  //
  //
  //   Get.to(() => const MainNavScreen());
  //   //return  ;
  //
  // }
  // // Apple Sign in


  // Log out user account
  Future<void> logout() async => await _auth.signOut(
  );

}