import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AuthController extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: Implement actual login logic
      await Future.delayed(const Duration(seconds: 2)); // Simulating API call
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw e.toString();
    }
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: Implement actual signup logic
      await Future.delayed(const Duration(seconds: 2)); // Simulating API call
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw e.toString();
    }
  }
} 