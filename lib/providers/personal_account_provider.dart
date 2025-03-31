import 'dart:io';

import 'package:craft_school/dto/CustomerInfoResponse.dart' as custInfo;
import 'package:craft_school/dto/FetchCustomerInfoResponse.dart' as fetchCustomer;
import 'package:craft_school/dto/GetAllPlanResponse.dart';
import 'package:craft_school/dto/LogoutResponse.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/screens/settings.dart';
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

import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class PersonalAccountProvider with ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
 TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
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
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value != passwordController.text) {
      return 'Confirm Password should match your new password';
    }
    return null;
  }
  // Method to validate form
  bool validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }
bool _isLoading = false;
   bool get isLoading => _isLoading;

  // Set loading state
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  
  List<Datum> _data = [];

  // Getter to retrieve the list of Datum
  List<Datum> get plandata => _data;

  // Setter to set the list of Datum
  set plandata(List<Datum> newData) {
    _data = newData;
  }
   Future<void> getPlanListAPI() async {
    // Set loading to true when the API request starts
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = "";
      print(jsonbody);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.getAllPlan,
        (response) async {
          GetAllPlanResponse resp = response;

          if (resp.status == true) {
            // Updating the lists with fetched data
           plandata=resp.data;

            // Once data is fetched, set isLoading to false
            isLoading = false;
          }
        },
        (error) {
          // Handle error case
          print('ERR msg is $error');
          ShowDialogs.showToast("Server Not Responding");

          // Set loading to false in case of an error
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");

      // Set loading to false when no internet
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }
 List<custInfo.Datum> data=[];
   Future<void> getCustomerInfoAPI() async {
    // Set loading to true when the API request starts
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = "";
      print(jsonbody);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.settingCustomerInfo,
        (response) async {
          custInfo.CustomerInfoResponse resp = response;

          if (resp.status == true) {
            // Updating the lists with fetched data
           phoneNumberController.text=resp.data[0].customer[0].phoneNo;
           firstNameController.text=resp.data[0].customer[0].firstName;
           lastNameController.text=resp.data[0].customer[0].lastName;
           emailController.text=resp.data[0].customer[0].email;
          //  passwordController.text=resp.data.customer.
         data=resp.data;
          notifyListeners();
            // Once data is fetched, set isLoading to false
            isLoading = false;
          }
        },
        (error) {
          // Handle error case
          print('ERR msg is $error');
          ShowDialogs.showToast("Server Not Responding");

          // Set loading to false in case of an error
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");

      // Set loading to false when no internet
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }

Future<Map<String, dynamic>> createRequestBody(String token) async {
    return {
      "token":token!=""?token: await SPManager().getAuthToken(),
      
    };
  }
 Future<void> logoutAPI(String token) async {
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = await createRequestBody(token);
     

      APIManager().apiRequest(routeGlobalKey.currentContext!, API.logout,
          (response) async {
        CommonResponse resp = response;
        // if (response['status'] == true) {
         if (resp.status == true) {
          print("success");
          if(token=="")
          {
 ShowDialogs.showToast(resp.message);
          SPManager().setAuthToken("");
          Navigator.of(
            routeGlobalKey.currentContext!,
          ).pushNamed(
            SignInScreen.route,
          );
          }else{
            
          }
       
         
         }
        // } else {
        //   // Handle failu
        //   print("response status fail");
        //   print(response['errors']);

        // }
      }, (error) {
     
        ShowDialogs.showToast("Server Not Responding");
      }, jsonval: jsonbody);
    } else {
      /// Navigator.of(_keyLoader.currentContext).pop();
      ShowDialogs.showToast("Please check internet connection");
    }
  }
String profileImageUrl = '';
  ///fetch
     Future<void> getFetchCustomerInfoAPI() async {
    // Set loading to true when the API request starts
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = "";
      print(jsonbody);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.fetchCustomerInfo,
        (response) async {
          fetchCustomer.FetchCustomerInfoResponse resp = response;

          if (resp.status == true) {
            // Updating the lists with fetched data
           phoneNumberController.text=resp.data[0].phoneNo;
           firstNameController.text=resp.data[0].firstName;
           lastNameController.text=resp.data[0].lastName;
           emailController.text=resp.data[0].email;
          profileImageUrl =resp.data[0].userProfilePic ?? '';
          notifyListeners();
            // Once data is fetched, set isLoading to false
            isLoading = false;
          }
        },
        (error) {
          // Handle error case
          print('ERR msg is $error');
          ShowDialogs.showToast("Server Not Responding");

          // Set loading to false in case of an error
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");

      // Set loading to false when no internet
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }
//  Map<String, dynamic> createUpdateInfoRequestBody() {
//     return {
//        "first_name":firstNameController.text,
//     "last_name":lastNameController.text,
//     "phone_no":phoneNumberController.text
//     };
//   }
//     Future<void> getUpdateCustomerInfoAPI() async {
//     // Set loading to true when the API request starts
//     isLoading = true;

//     var status1 = await ConnectionDetector.checkInternetConnection();

//     if (status1) {
//       dynamic jsonbody =createUpdateInfoRequestBody();
//       print(jsonbody);

//       return APIManager().apiRequest(
//         routeGlobalKey.currentContext!,
//         API.updatePersonalInfo,
//         (response) async {
//           CommonResponse resp = response;

          
//        ShowDialogs.showToast(resp.message);

//             // Once data is fetched, set isLoading to false
//             isLoading = false;
          
//         },
//         (error) {
//           // Handle error case
//           print('ERR msg is $error');
//           ShowDialogs.showToast("Server Not Responding");
          
//           // Set loading to false in case of an error
//           isLoading = false;
//         },
//         jsonval: jsonbody,
//       );
//     } else {
//       // No internet connection
//       ShowDialogs.showToast("Please check internet connection");

//       // Set loading to false when no internet
//       isLoading = false;
//       return Future.error("No Internet Connection");
//     }
//   }

Future<void> getUpdateCustomerInfoAPI( List<File> files) async {
  isLoading=true;
  var uri = Uri.parse(APIManager.updatePersonalInfo);
  
  // Creating a multipart request
  var request = http.MultipartRequest('POST', uri);

  // Add the post text as form data
  request.fields['first_name'] =firstNameController.text;
    request.fields['last_name'] = lastNameController.text;
      request.fields['phone_no'] =phoneNumberController.text;
        request.fields['email'] = emailController.text;

  // Add the files to the request
  for (var file in files) {
    var mimeType = lookupMimeType(file.path); // Get mime type based on file extension
    var multipartFile = await http.MultipartFile.fromPath(
      'profile_pic', 
      file.path, 
      contentType: mimeType != null ? MediaType.parse(mimeType) : MediaType('application', 'octet-stream')
    );
    request.files.add(multipartFile);
  }

  // Add authorization header
  request.headers['Authorization'] = 'Bearer ${GlobalLists.authtoken}';

  // Sending the request
  var response = await request.send();

  // Handle the response
  if (response.statusCode == 200) {
    // Success
    print('Post uploaded successfully');
    var responseData = await response.stream.bytesToString();
    print('Response: $responseData');
           Navigator.of(routeGlobalKey.currentContext!)
                        .pushNamed(
                          Settings.route,
                        )
                        .then((value) {});
    isLoading=false;
  } else {
    // Failure
    print('Error: ${response.statusCode}');
    isLoading=false;
  }

}

   Map<String, dynamic> createUpdatePasswordRequestBody() {
    return {
        "email":emailController.text,
    "password":passwordController.text,
    "confirm_password":confirmpasswordController.text

    };
   }
    Future<void> getUpdatepasswordAPI() async {
    // Set loading to true when the API request starts
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody =createUpdatePasswordRequestBody();
      print(jsonbody);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.updateCustomerPassword,
        (response) async {
          CommonResponse resp = response;

          
       ShowDialogs.showToast(resp.message);

            // Once data is fetched, set isLoading to false
            isLoading = false;
          
        },
        (error) {
          // Handle error case
          print('ERR msg is $error');
          ShowDialogs.showToast("Server Not Responding");
          
          // Set loading to false in case of an error
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");

      // Set loading to false when no internet
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }
}
