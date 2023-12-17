import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserIdProvider extends ChangeNotifier {
  String? _userId;

  String? get userId => _userId;

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }
}
