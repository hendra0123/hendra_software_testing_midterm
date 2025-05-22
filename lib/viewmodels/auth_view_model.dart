// lib/viewmodels/auth_view_model.dart
import 'package:flutter/material.dart';
import 'package:hendra_software_testing_midterm/models/user.dart';

import '../models/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;

  User? user;

  AuthViewModel(this._authService);

  String? validateUsername(String username) {
    if (username.isEmpty) {
      return 'Username cannot be empty.';
    }
    if (username.length < 3 || username.length > 20) {
      return 'Username must be between 3 and 20 characters.';
    }
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(username)) {
      return 'Username contains invalid characters.';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty.';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  Future<String?> login(String username, String password) async {
    try {
      final result = await _authService.login(username, password);
      user = User.fromJson(result); // <- Simpan user
      print(result);
      return null; // Login berhasil
    } catch (e) {
      print(e);
      return e.toString(); // Login gagal
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    user = null; // <- Clear user
  }
}
