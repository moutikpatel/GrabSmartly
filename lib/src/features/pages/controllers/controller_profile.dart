import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grabsmartly/src/repository/authentication/authentication_repository.dart';
import 'package:grabsmartly/src/repository/user_repository/user_repository.dart';

import '../../auth/models/user_data_model.dart';

class ProfileController extends GetxController{
  final _authRepository = Get.put(AuthenticationRepository());
  final _userRepository = Get.put(UserRepository());

  static ProfileController get instance => Get.find();

  getUserData(){
    final email = _authRepository.fireBaseUser.value?.email;

    if(email != null){
      return _userRepository.getUserDetails(email);
    }
    else{
      Get.snackbar("Error", "Please Login To Continue");
    }
  }
  Future<void> updateUserProfile(UserDataModel userData) async {
    try {
      // Fetch the current Firebase user
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print("User is not signed in");
        return;
      }

      // Use the user ID as the document ID
      String userId = user.uid;

      // Reference to the user document
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('Users').doc(userId);

      // Update the user's data in Firestore
      await userDocRef.update({
        'FullName': userData.fullName,
        'Password': userData.password,
        // Add other fields as needed
      });

      print("User profile updated successfully");
    } catch (error) {
      print("Error updating user profile: $error");
    }
  }

}

