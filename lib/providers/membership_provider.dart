
import 'package:flutter/material.dart';


class MembershipProvider with ChangeNotifier {
  
int selectedPlanIndex = -1; // No plan is selected initially

  // Function to update selected plan index
  void selectPlan(int index) {
  
      selectedPlanIndex = index; // Update selected plan
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
}
