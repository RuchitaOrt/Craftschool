
import 'package:craft_school/dto/TestimonialResponse.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';

import 'package:craft_school/utils/internetConnection.dart';
import 'package:flutter/material.dart';

class TestimonialProvider with ChangeNotifier {

   bool _isLoading = false;
  
  // Loading state
  bool get isLoading => _isLoading;

  // Set loading state
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
 
List<Datum> _testimonialData = [];

  // Getter for serviceData
  List<Datum> get testimonialData => _testimonialData;

  // Setter for serviceData
  set testimonialData(List<Datum> data) {
    _testimonialData = data;
    notifyListeners(); // Notify listeners to update the UI
  }
  // API call for home screen data
  Future<void> getTestimonialAPI() async {
    // Set loading to true when the API request starts
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = "";
      
      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.testimonials,
        (response) async {
          TestimonialResponse resp = response;

          if (resp.status == true) {
           testimonialData=resp.data!;
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
}

