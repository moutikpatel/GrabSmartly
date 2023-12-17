import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataModel {
  String? id;
  String fullName;
  String email;
  String phoneNo;
  String password;
  String? img;

  UserDataModel({
    this.id,
    this.img,
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.password,
  });

  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
      "Image": img,
    };
  }

  // Setter for updating fullName
  setFullName(String newFullName) {
    fullName = newFullName;
  }

  // Factory method to create an instance from Google user data
  factory UserDataModel.fromGoogleUser(User user) {
    return UserDataModel(
      fullName: user.displayName ?? '',
      email: user.email ?? '',
      phoneNo: '', // You might not get phone number from Google sign-in
      password: '', // You might not get password from Google sign-in
      img: user.photoURL ?? '',
    );
  }

  // Factory method to create an instance from a document snapshot
  factory UserDataModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserDataModel(
      id: document.id,
      fullName: data["FullName"],
      email: data["Email"],
      phoneNo: data["Phone"],
      password: data["Password"],
      img: data["Image"],
    );
  }
}
