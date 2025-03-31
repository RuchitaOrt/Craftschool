import 'dart:io';

import 'package:craft_school/dto/LogoutResponse.dart';
import 'package:craft_school/dto/SavedCourseResponse.dart';
import 'package:craft_school/dto/SignUpResponse.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/screens/Landing_Screen.dart';
import 'package:craft_school/screens/savedCourse.dart';
import 'package:craft_school/screens/signIn_screen.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/GlobalLists.dart';
import 'package:craft_school/utils/SPManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/internetConnection.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/regex_helper.dart';

class SignUpProvider with ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
    TextEditingController reasonController = TextEditingController();

  bool _isPasswordObscured = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegexHelper _regexHelper = RegexHelper();

  // Getter for formKey
  GlobalKey<FormState> get formKey => _formKey;
  bool get isPasswordObscured => _isPasswordObscured;

  // Toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordObscured = !_isPasswordObscured;
    notifyListeners();
  }

  // Validators
  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'First Name cannot be empty';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last Name cannot be empty';
    }
    return null;
  }


  String? validateReason(String? value) {
    if (value == null || value.isEmpty) {
      return 'Reason cannot be empty';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number cannot be empty';
    } else if (value.length != 10) {
      return 'Phone Number should be 10 digits';
    }
    return null;
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

  // Method to validate form
  bool validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  Map<String, dynamic> createRequestBody() {
    return {
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "phone_no": phoneNumberController.text,
      "password": passwordController.text,
      "category_id": GlobalLists.selectedCategoryChipId,
      "browser_Name": "App",
      "device_Type": Platform.isAndroid ? "Android" : "IOS"
    };
  }

  createSignup() async {
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createRequestBody();
      print(jsonbody);

      APIManager().apiRequest(routeGlobalKey.currentContext!, API.signUp,
          (response) async {
        SignUpResponse resp = response;
        // if (response['status'] == true) {
        if (resp.status == true) {
          ShowDialogs.showToast(resp.message);
            SPManager().setAuthToken(resp.data[0].token);
         SPManager().setCustomerID(resp.data[0].customerId.toString());
         SPManager().setCustomerName(resp.data[0].name);
          Navigator.of(
            routeGlobalKey.currentContext!,
          ).pushNamed(
            LandingScreen.route,arguments:true
          );
        }
        // } else {
        //   // Handle failu
        //   print("response status fail");
        //   print(response['errors']);

        // }
      }, (error) {
        print('ERR SignUpResponse is $error');

        ShowDialogs.showToast("Server Not Responding");
      }, jsonval: jsonbody);
    } else {
      /// Navigator.of(_keyLoader.currentContext).pop();
      ShowDialogs.showToast("Please check internet connection");
    }
  }
  Map<String, dynamic> createContactUsRequestBody() {
    return {
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "phone_no": phoneNumberController.text,
      "reason": reasonController.text,
      
    };
  }


    contactUsAPI() async {
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createContactUsRequestBody();
      print(jsonbody);

      APIManager().apiRequest(routeGlobalKey.currentContext!, API.contact_us,
          (response) async {
        SavedCoursesResponse resp = response;
        // if (response['status'] == true) {
        if (resp.status == true) {
          ShowDialogs.showToast(resp.message);
           
          Navigator.of(
            routeGlobalKey.currentContext!,
          ).pushNamed(
            LandingScreen.route,
          );
        }
      
      }, (error) {
        print('ERR SignUpResponse is $error');

        ShowDialogs.showToast("Server Not Responding");
      }, jsonval: jsonbody);
    } else {
      /// Navigator.of(_keyLoader.currentContext).pop();
      ShowDialogs.showToast("Please check internet connection");
    }
  }

   joinFlimFestAPI() async {
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createContactUsRequestBody();
      print(jsonbody);

      APIManager().apiRequest(routeGlobalKey.currentContext!, API.storeCustomerFlimFestival,
          (response) async {
        CommonResponse resp = response;
        // if (response['status'] == true) {
        if (resp.status == true) {
          ShowDialogs.showToast(resp.message);
           
          Navigator.of(
            routeGlobalKey.currentContext!,
          ).pushNamed(
            LandingScreen.route,
          );
        }
      
      }, (error) {
        print('ERR SignUpResponse is $error');

        ShowDialogs.showToast("Server Not Responding");
      }, jsonval: jsonbody);
    } else {
      /// Navigator.of(_keyLoader.currentContext).pop();
      ShowDialogs.showToast("Please check internet connection");
    }
  }
}
