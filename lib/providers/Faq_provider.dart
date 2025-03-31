
import 'package:craft_school/dto/FAQResponse.dart';

import 'package:craft_school/main.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';

import 'package:craft_school/utils/internetConnection.dart';
import 'package:flutter/material.dart';

class FAQProvider with ChangeNotifier {

   bool _isLoading = false;
  
  // Loading state
  bool get isLoading => _isLoading;

  // Set loading state
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
    List<Datum> _faqList = [];

  // Getter for data
  List<Datum> get faqList => _faqList;
  set faqList(List<Datum> data) {
    _faqList = data;
    notifyListeners();
  }

  Future<void> getFAQAPI() async {
    // Set loading to true when the API request starts
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = "";
      
      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.faq,
        (response) async {
          FaqResponse resp = response;

          if (resp.status == true) {
 faqList=resp.data;
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

