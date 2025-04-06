import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:savings_app/utils/popup.dart';

class RegisterViewModel extends ChangeNotifier {
  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void togglePasswordConfirmVisibility() {
    _obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  Future<void> submitRegister(BuildContext context) async {
    if (firstNameController.text.isEmpty || emailController.text.isEmpty ||
        passwordController.text.isEmpty || passwordController.text.isEmpty) {
      PopupUtils.showError(context, 'Please fill in missing fields');
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      PopupUtils.showError(context, 'Password confirmation does not match');
      return;
    }

    _isLoading = true;
    notifyListeners();

    final body = {
      "email": emailController.text.toString(),
      "password": passwordController.text.toString()
    };

    final response;
    try {
      response = await http.post(
          Uri.parse('${dotenv.get('API_URL')}/auth/register'),
          body: jsonEncode(body), headers: {
        'Content-Type': 'application/json'
      }).timeout(Duration(seconds: 3));
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      PopupUtils.showError(context, 'Unable to register');
      return;
    }

    if (response.statusCode != 200) {
      _isLoading = false;
      notifyListeners();
      print(jsonDecode(response.body));
      PopupUtils.showError(context, 'Unable to register');
      return;
    }

    _isLoading = false;
    notifyListeners();

    PopupUtils.showSuccess(context, 'Registered Successfully');

    Navigator.pushNamedAndRemoveUntil(
        context,
        '/verify',
        (Route<dynamic> route) => false,
        arguments: {"email": emailController.text.toString()}
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}