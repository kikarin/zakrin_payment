import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _userName = '';
  String _userEmail = '';

  String get userName => _userName;
  String get userEmail => _userEmail;

  void updateUser(String name, String email) {
    _userName = name;
    _userEmail = email;
    notifyListeners();
  }
} 