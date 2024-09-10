import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final LoginService _loginService = LoginService();
  // LoginResponse? responfromdata;

  Future<void> login(BuildContext context) async {}
}
