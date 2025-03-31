import 'dart:io';

import 'package:craft_school/dto/LoginResponse.dart';
import 'package:craft_school/dto/LogoutResponse.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/screens/Landing_Screen.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/GlobalLists.dart';
import 'package:craft_school/utils/SPManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/internetConnection.dart';

import 'package:flutter/material.dart';
import 'package:craft_school/utils/regex_helper.dart';

class SignInProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool _isPasswordObscured = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegexHelper _regexHelper = RegexHelper();
  bool _isExploreChecked = false;

  // Getter
  bool get isExploreChecked => _isExploreChecked;

  // Setter
  set isExploreChecked(bool value) {
   
      _isExploreChecked = value;
    notifyListeners();
  }

  // Getter for formKey
  GlobalKey<FormState> get formKey => _formKey;
  bool get isPasswordObscured => _isPasswordObscured;
  String? selectedChip;
  // Toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordObscured = !_isPasswordObscured;
    notifyListeners();
  }

  String? validateEmailField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!_regexHelper.isEmailIdValid(value)) {
      return 'Enter a valid Email ID';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value != passwordController.text) {
      return 'Confirm Password should match your new password';
    }
    return null;
  }

  bool _isChecked = false;

  bool get isChecked => _isChecked;

  void toggleCheckbox(bool? value) {
    _isChecked = value ?? false;
    notifyListeners(); // Notify listeners when the state changes
  }

  // Method to validate form
  bool validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  final List<Map<String, String>> chipAccountData = [
    {'label': 'Google', 'image': CraftImagePath.google},
    {'label': 'Apple', 'image': CraftImagePath.apple},
  ];
  var getToken = "";
  void onSingleChipSelected(String? label) {
    selectedChip = label; // Update the selected chip
    // if(label=="Google")
    // {
    //   signInWithGoogle();
    // }
    notifyListeners();
  }

  Map<String, dynamic> createRequestBody() {
    return {
      "email": emailController.text,
      "password": passwordController.text,
      "browser_Name": "App",
      "device_Type": Platform.isAndroid ? "Android" : "IOS"
    };
  }

  createSignIn() async {
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createRequestBody();
      print(jsonbody);

      APIManager().apiRequest(routeGlobalKey.currentContext!, API.login,
          (response) async {
        LoginResponse resp = response;

       if(resp.status==true)
       {
         ShowDialogs.showToast(resp.message);
         SPManager().setAuthToken(resp.data[0].token);
         SPManager().setCustomerID(resp.data[0].customerId.toString());
         SPManager().setCustomerName(resp.data[0].name);
        
        Navigator.of(
          routeGlobalKey.currentContext!,
        ).pushNamed(
          LandingScreen.route,
        );
       }
      }, (error) {
        print('ERR msg is $error');

        ShowDialogs.showToast("Server Not Responding");
      }, jsonval: jsonbody);
    } else {
      /// Navigator.of(_keyLoader.currentContext).pop();
      ShowDialogs.showToast("Please check internet connection");
    }
  }



  Map<String, dynamic> createExploreRequestBody() {
    return {
      "email": emailController.text,
      "Status": isExploreChecked?"1":"0",
     
    };
  }
   exploreCourse() async {
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createExploreRequestBody();
      print(jsonbody);

      APIManager().apiRequest(routeGlobalKey.currentContext!, API.news_letter,
          (response) async {
        CommonResponse resp = response;

       if(resp.status==true)
       {
         ShowDialogs.showToast(resp.message);
        
        Navigator.of(
          routeGlobalKey.currentContext!,
        ).pushNamed(
          LandingScreen.route,
        );
       }
      }, (error) {
        print('ERR msg is $error');

        ShowDialogs.showToast("Server Not Responding");
      }, jsonval: jsonbody);
    } else {
      /// Navigator.of(_keyLoader.currentContext).pop();
      ShowDialogs.showToast("Please check internet connection");
    }
  }
}
