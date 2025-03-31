
import 'package:craft_school/dto/GetmembershipPlanResponse.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/internetConnection.dart';
import 'package:flutter/material.dart';


class MembershipProvider with ChangeNotifier {
  
int selectedPlanIndex = -1; // No plan is selected initially
String selectedPlanTitle = "";
String selectedPlanPrice = "";
  // Function to update selected plan index
  void selectPlan(int index) {
  
      selectedPlanIndex = index; // Update selected plan
      print(selectedPlanIndex);
    notifyListeners();
  }
    void selectPlanTitle(String title) {
  
      selectedPlanTitle = title; // Update selected plan
      print(selectedPlanIndex);
    notifyListeners();
  }
     void selectPlanPrice(String price) {
  
      selectedPlanPrice = price; // Update selected plan
      print(selectedPlanIndex);
    notifyListeners();
  }
  bool _isChangePlan = false; // Private variable to store the value

  // Getter for _isChangePlan
  bool get isChangePlan => _isChangePlan;

  // Setter for _isChangePlan
  set isChangePlan(bool value) {
    _isChangePlan = value;
    
  }
  confirmationPlan()
  {_isChangePlan=true;
notifyListeners();
  }
  bool _isMembershipLoading = false;
  bool get isMembershipLoading => _isMembershipLoading;

  set isMembershipLoading(bool value) {
    _isMembershipLoading = value;
    notifyListeners();
  }
List<Datum> _membershipList = [];

  // Getter for data
  List<Datum> get membershipList => _membershipList;
  set membershipList(List<Datum> data) {
    _membershipList = data;
  }
   Future<void> getMembershipPlanAPI() async {
    isMembershipLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = "";

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.membership,
        (response) async {
            print("membershipListapu");
          GetmembershipPlanResponse resp = response;

          if (resp.status == true) {
            // Append the new blogs to the list
           _membershipList=resp.data;
                isMembershipLoading = false;
           print("membershipList");
           print(membershipList);
            notifyListeners();
          }
        },
        (error) {
          // Handle error case
          print('Error: $error');
          ShowDialogs.showToast("Server Not Responding");
          isMembershipLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isMembershipLoading = false;
      return Future.error("No Internet Connection");
    }
  }

}
