import 'package:craft_school/dto/ForgetpasswordResponse.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/screens/create_password_screen.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/internetConnection.dart';
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
 
  //  updatePassword() async {
  //   var status1 = await ConnectionDetector.checkInternetConnection();

  //   if (status1) {
  //     dynamic jsonbody = createupdatePasswordRequestBody();
  //     print(jsonbody);

  //     APIManager().apiRequest(routeGlobalKey.currentContext!, API.forgetPassword,
  //         (response) async {
  //       ForgetpasswordResponse resp = response;

  //      if(resp.status==true)
  //      {
  //        ShowDialogs.showToast(resp.message);
        
  //       Navigator.of(
  //         routeGlobalKey.currentContext!,
  //       ).pushNamed(
  //         CreatePasswordScreen.route,
  //       );
  //      }
  //     }, (error) {
  //       print('ERR msg is $error');

  //       ShowDialogs.showToast("Server Not Responding");
  //     }, jsonval: jsonbody);
  //   } else {
  //     /// Navigator.of(_keyLoader.currentContext).pop();
  //     ShowDialogs.showToast("Please check internet connection");
  //   }
  // }
}
