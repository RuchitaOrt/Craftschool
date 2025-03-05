import 'package:flutter/material.dart';
import 'package:craft_school/utils/regex_helper.dart';

class ForgetPasswordProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 

  // Getter for formKey
  GlobalKey<FormState> get formKey => _formKey;
  final RegexHelper _regexHelper = RegexHelper();

  String? validateEmailField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!_regexHelper.isEmailIdValid(value)) {
      return 'Enter a valid Email ID';
    }
    return null;
  }
   bool validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }
}
