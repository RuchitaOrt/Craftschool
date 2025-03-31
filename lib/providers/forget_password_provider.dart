import 'package:craft_school/dto/ForgetPasswordDTO.dart';
import 'package:craft_school/dto/ForgetpasswordResponse.dart';
import 'package:craft_school/dto/LogoutResponse.dart';
import 'package:craft_school/dto/UpdatepasswordResponse.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/screens/create_password_screen.dart';
import 'package:craft_school/screens/forgetpassword_screen.dart';
import 'package:craft_school/screens/signIn_screen.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/internetConnection.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/regex_helper.dart';

class ForgetPasswordProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
    TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 
 TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool _isPasswordObscured = true;
  
  final RegexHelper _regexHelper = RegexHelper();

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

  String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Valid OTP';
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

 
   bool validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }
 Map<String, dynamic> createRequestBody() {
    return {
      "email": emailController.text,
      
    };
  }
   forgetPassword() async {
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createRequestBody();
      print(jsonbody);

      APIManager().apiRequest(routeGlobalKey.currentContext!, API.forgetPassword,
          (response) async {
        ForgetpasswordResponse resp = response;

       if(resp.status==true)
       {
         ShowDialogs.showToast(resp.message);
        
        Navigator.of(
          routeGlobalKey.currentContext!,
        ).pushNamed(
          CreatePasswordScreen.route,
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
  Map<String, dynamic> createUpdatePaasowrdRequestBody() {
    return {
    "otp":otpController.text,
    "new_password":passwordController.text,
    "confirm_password":confirmpasswordController.text
      
    };
  }
   updatePassword() async {
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createUpdatePaasowrdRequestBody();
      print(jsonbody);

      APIManager().apiRequest(routeGlobalKey.currentContext!, API.updatePassword,
          (response) async {
        UpdatepasswordResponse resp = response;

       if(resp.status==true)
       {
         ShowDialogs.showToast(resp.message);
         Navigator.pushNamed(
                          routeGlobalKey.currentContext!,
                          ForgetpasswordScreen.route,
                          arguments: ForgetPasswordDTO(
                              title: CraftStrings.strResetpasswordSuccesfully,
                              detailText: CraftStrings
                                  .strResetpasswordSuccesfullyDetail,
                              emailHint: CraftStrings.strEmail,
                              buttonText: CraftStrings.strSignIn,
                              signInText: CraftStrings.strHome,
                              isEmailSectionnVisble: false,
                              onButtonOnTap: () {
                                Navigator.of(
                                  routeGlobalKey.currentContext!,
                                ).pushNamedAndRemoveUntil(
                                  SignInScreen.route,
                                  (route) => false,
                                );
                              },
                              onTextOnTap: () {}),
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
