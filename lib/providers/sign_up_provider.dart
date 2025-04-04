import 'dart:convert';
import 'dart:io';
import 'dart:math';

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
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

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

  List<String> careerFields = [
    "Software Engineer",
    "Designer",
    "Marketing",
    "Finance"
  ];
 String? selectedCareerField;
  List<String>? resumeFile=[];

  void setSelectedCareerField(String value) {
    selectedCareerField = value;
    notifyListeners();
  }

  void setResumeFile(List<String>? filePath) {
    resumeFile = filePath;
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
String? validateCareerField(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select a career field";
    }
    return null;
  }

  String? validateResume(List<String>? files) {
    if (files == null || files.isEmpty) {
      return "Please upload at least one resume";
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
          ).pushNamed(LandingScreen.route, arguments: true);
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

  Map<String, dynamic> createflimRequestBody(
      String id, String name, String phoneNo, String email) {
    return {
      "flim_festival_id": id,
      "name": name,
      "phone_no": phoneNo,
      "email": email
    };
  }

  joinFlimFestAPI(String id, String name, String phoneNo, String email) async {
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createflimRequestBody(id, name, phoneNo, email);
      print(jsonbody);

      APIManager().apiRequest(
          routeGlobalKey.currentContext!, API.storeCustomerFlimFestival,
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

  bool _isResumeLoading = false;
  bool get isResumeLoading => _isResumeLoading;

  set isResumeLoading(bool value) {
    _isResumeLoading = value;
    notifyListeners();
  }

  Future<void> uploadResume() async {
    isResumeLoading = true;
    var uri = Uri.parse(APIManager.careerSave);

    // Creating a multipart request
    var request = http.MultipartRequest('POST', uri);

    // Add the post text as form data
    request.fields['first_name'] = firstNameController.text;
    request.fields['last_name'] = lastNameController.text;
    request.fields['email'] = emailController.text;
    request.fields['phone_no'] = phoneNumberController.text;
    request.fields['position'] = selectedCareerField!;

    // Add the files to the request
    for (var file in resumeFile!) {
      var mimeType =
          lookupMimeType(file); // Get mime type based on file extension
      var multipartFile = await http.MultipartFile.fromPath('resume', file,
          contentType: mimeType != null
              ? MediaType.parse(mimeType)
              : MediaType('application', 'octet-stream'));
      request.files.add(multipartFile);
    }

    // Add authorization header
    request.headers['Authorization'] = 'Bearer ${GlobalLists.authtoken}';

    // Sending the request
    var response = await request.send();

    // Handle the response
    if (response.statusCode == 200) {
      // Success
   
      var responseData = await response.stream.bytesToString();
      // Decode the JSON string into a Map
var decodedJson = json.decode(responseData);

// Access the "message" key
String message = decodedJson["message"];
      print('Response: $responseData');
      
      ShowDialogs.showToast(message);
        Navigator.of(routeGlobalKey.currentContext!)
                        .pushNamed(
                          LandingScreen.route,
                        )
                        .then((value) {});

      isResumeLoading = false;
    } else {
      // Failure
      print('Error: ${response.statusCode}');
      isResumeLoading = false;
    }
  }
}
