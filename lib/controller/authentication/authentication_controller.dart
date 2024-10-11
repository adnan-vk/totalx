import 'package:flutter/material.dart';
import 'package:totalx/service/authethentication/authentication_service.dart';

class AuthenticationController extends ChangeNotifier {
  AuthenticationService authenticationService = AuthenticationService();
  TextEditingController phoneController = TextEditingController();

  Future<void> getOtp(phoneNumber) async {
    await authenticationService.getOtp(phoneNumber);
    notifyListeners();
  }
}
