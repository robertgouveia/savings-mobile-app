
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
    if (firstNameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty || passwordController.text.isEmpty) {
      PopupUtils.showError(context, 'Please fill in missing fields');
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      PopupUtils.showError(context, 'Password confirmation does not match');
      return;
    }

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    _isLoading = false;
    notifyListeners();

    PopupUtils.showSuccess(context, 'Registered Successfully');
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