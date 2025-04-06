import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:savings_app/utils/popup.dart';
import 'package:http/http.dart' as http;

class LoginViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  bool get obscurePassword => _obscurePassword;
  bool get isLoading => _isLoading;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<void> submitLogin(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      PopupUtils.showError(context, "Please fill in empty fields.");
      return;
    }

    _isLoading = true;
    notifyListeners();

    final response;
    try{
       response = await http.get(Uri.parse('${dotenv.get('API_URL')}/health')).timeout(Duration(seconds: 3));
    } catch(e) {
      _isLoading = false;
      notifyListeners();
      PopupUtils.showError(context, 'Unable to connect to server!');
      return;
    }

    final data = jsonDecode(response.body);
    bool db = data['data']['status']['database'];

    if (!db) {
      PopupUtils.showError(context, 'Unable to connect to the database!');
      return;
    }

    _isLoading = false;
    notifyListeners();

    PopupUtils.showSuccess(context, "Logged in successfully.");
    Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}