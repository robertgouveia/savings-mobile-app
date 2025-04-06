import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:savings_app/utils/popup.dart';

class VerificationViewModel extends ChangeNotifier {
  List<TextEditingController> codeControllers = List.generate(
      6, (_) => TextEditingController());

  String _email = '';

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  Future<void> submitVerification(BuildContext context) async {
    final code = codeControllers.map((controller) => controller.text).join();

    final response;
    try {
      response = await http.put(Uri.parse('${dotenv.get('API_URL')}/auth/verify'), headers: {
        'Content-Type': 'application/json'
      }, body: jsonEncode({
        "email": _email,
        "code": code
      }));
    } catch(e) {
      PopupUtils.showError(context, 'Unable to send verification code.');
      _isLoading = false;
      notifyListeners();
      return;
    }

    if(response.statusCode != 200) {
      PopupUtils.showError(context, 'Invalid code!');
      _isLoading = false;
      notifyListeners();
      return;
    }

    PopupUtils.showSuccess(context, 'Verified!');
    _isLoading = false;
    notifyListeners();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
  }

  @override
  void dispose() {
    super.dispose();
  }
}