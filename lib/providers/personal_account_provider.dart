import 'package:craft_school/dto/GetAllPlanResponse.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/internetConnection.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/regex_helper.dart';

class PersonalAccountProvider with ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();


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
  //   Future<void> getPlanList() async {
  //   isLoading = true;
  //   notifyListeners();

  //   var status1 = await ConnectionDetector.checkInternetConnection();

  //   if (status1) {
  //     var jsonbody = "";
  //     await APIManager().apiRequest(
  //       routeGlobalKey.currentContext!,
  //       API.getAllPlan,
  //       (response) {
  //         GetAllPlanResponse resp = response;
  //         plandata = resp.data;
  //         isLoading = false;
  //         notifyListeners();
  //       },
  //       (error) {
  //         isLoading = false;
         
  //         notifyListeners();
  //         ShowDialogs.showToast("Server Not Responding");
  //       },
  //       path: jsonbody,
  //     );
  //   } else {
  //     isLoading = false;
     
  //     notifyListeners();
  //     ShowDialogs.showToast("Please check internet connection");
  //   }
  // }
}
