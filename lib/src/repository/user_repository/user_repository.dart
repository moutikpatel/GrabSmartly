import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grabsmartly/src/features/auth/models/user_data_model.dart';

class UserRepository extends GetxController{

  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  String generateRandomId(int length) {
    final random = Random.secure();
    const charset = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(length, (index) {
      final randomIndex = random.nextInt(charset.length);
      return charset[randomIndex];
    }).join('');
  }

  // Store User Credentials in Firebase
  Future<void> createUser(UserDataModel user) async {
    try {
      // Generate a random custom ID with length 28
      String customDocumentId = generateRandomId(28);

      // Create a reference to the document with the random custom ID
      DocumentReference userDocRef = _db.collection("Users").doc(customDocumentId);

      // Set the document data
      await userDocRef.set(user.toJson());

      // Display success message
      Get.snackbar(
        "Success",
        "Account created Successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (error) {
      // Handle errors
      print("Error creating user: $error");
      // Display error message
      Get.snackbar(
        "Error",
        "Failed to create account. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  //Fetch User Data from firebase
  Future<UserDataModel> getUserDetails(String email) async{
    final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserDataModel.fromSnapShot(e)).single;
    return userData;
  }

  // Inside UserRepository or wherever addItemToFirestore is implemented
  Future<void> addItemToFirestore(String userId, String itemId) async {
    try {
      // Get a reference to the user's document in Firestore
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('Users').doc(userId);

      // Check if the document exists
      DocumentSnapshot userDoc = await userDocRef.get();
      if (userDoc.exists) {
        // If the document exists, add the item to a subcollection or a field inside the user's document
        await userDocRef.collection('groceryList').doc(itemId).set({
          // Item details
          'itemId': itemId,
          // Add other details as needed
        });

        print('Item added to the user\'s grocery list successfully');
      } else {
        print('User document does not exist');
      }
    } catch (error) {
      print('Error adding item to Firestore: $error');
      // Handle the error
    }
  }


}