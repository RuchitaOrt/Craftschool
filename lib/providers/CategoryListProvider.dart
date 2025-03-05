import 'package:craft_school/main.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/dto/CategoryListResponse.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/internetConnection.dart';

class CategoryListProvider with ChangeNotifier {
  List<Datum> _categoryList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Datum> get categoryList => _categoryList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? selectedChip;
  Set<String> selectedChips = Set<String>();


  void onChipSelected(String id) {

      if (selectedChips.contains(id)) {
        selectedChips.remove(id);
      } else {
        selectedChips.add(id);
      }
    notifyListeners();
  }
  // Fetch category list from API
  Future<void> getCategoryList() async {
    _isLoading = true;
    notifyListeners();

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      var jsonbody = "";
      await APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.categoryList,
        (response) {
          CategoryListResponse resp = response;
          _categoryList = resp.data;
          _isLoading = false;
          notifyListeners();
        },
        (error) {
          _isLoading = false;
          _errorMessage = "Server Not Responding";
          notifyListeners();
          ShowDialogs.showToast("Server Not Responding");
        },
        path: jsonbody,
      );
    } else {
      _isLoading = false;
      _errorMessage = "Please check internet connection";
      notifyListeners();
      ShowDialogs.showToast("Please check internet connection");
    }
  }
}
