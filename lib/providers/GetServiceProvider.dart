import 'package:craft_school/dto/GetServicesResponse.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/internetConnection.dart';
import 'package:flutter/material.dart';

class GetServiceProvider with ChangeNotifier {

   bool _isLoading = false;
  
  // Loading state
  bool get isLoading => _isLoading;

  // Set loading state
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  String getImagePath(int index) {
  switch (index) {
    case 0:
      return CraftImagePath.live;
      
    case 1:
      return CraftImagePath.community;
    case 2:
      return CraftImagePath.certificate;
    default:
      return CraftImagePath.industry;
  
  }
}
List<Datum> _serviceData = [];

  // Getter for serviceData
  List<Datum> get serviceData => _serviceData;

  // Setter for serviceData
  set serviceData(List<Datum> data) {
    _serviceData = data;
    notifyListeners(); // Notify listeners to update the UI
  }
  // API call for home screen data
  Future<void> getServiceAPI() async {
    // Set loading to true when the API request starts
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = "";
      
      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.getCraftschoolServices,
        (response) async {
          GetServicesResponse resp = response;
print("GetServicesResponse");
          if (resp.status == true) {
            print(resp.data);
           serviceData=resp.data;
            isLoading = false;
            notifyListeners();
          }
        },
        (error) {
          // Handle error case
        
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

