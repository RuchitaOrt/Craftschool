import 'dart:convert';

import 'package:craft_school/dto/CategoryListResponse.dart';
import 'package:craft_school/dto/CategoryWiseResponse.dart' as catWise;
import 'package:craft_school/main.dart';
import 'package:craft_school/providers/CoursesProvider.dart';
import 'package:flutter/material.dart';

import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/internetConnection.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CategoryListProvider with ChangeNotifier {
  List<Datum> _categoryList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Datum> get categoryList => _categoryList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? selectedChip;
  Set<String> selectedChips = Set<String>();
  String selectedSingleChips = "0";

  void onChipSelected(String id) {
    if (selectedChips.contains(id)) {
      selectedChips.remove(id);
    } else {
      selectedChips.add(id);
    }
    notifyListeners();
  }

  void onCategorySingleChipSelected(String id) {
    selectedSingleChips = "";
    selectedSingleChips = id;
    getCategoryWiseList([int.parse(id)]);
    notifyListeners();
  }

  // Fetch category list from API
  Future<void> getCategoryList() async {
    // selectedSingleChips="";
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
          selectedSingleChips = _categoryList[0].id.toString();
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

  bool _isCategoryWiseLoading = false;
  // Loading state
  bool get isCategoryWiseLoading => _isCategoryWiseLoading;

  // Set loading state
  set isCategoryWiseLoading(bool value) {
    _isCategoryWiseLoading = value;
    notifyListeners();
  }

  List<catWise.Datum> _categoryWiseList = [];

  // Getter for data
  List<catWise.Datum> get categoryWiseList => _categoryWiseList;
  set categoryWiseList(List<catWise.Datum> data) {
    _categoryWiseList = data;
  }

  Map<String, dynamic> createRequestBody(var categoryIds) {
    return {"category_ids": categoryIds, "start": "0", "length": "0"};
  }

  Future<void> getCategoryWiseList(List<int> categoryIds) async {
    categoryWiseList = [];
    _isCategoryWiseLoading = true;
    notifyListeners();

    bool hasInternet = await ConnectionDetector.checkInternetConnection();
    if (!hasInternet) {
      _isCategoryWiseLoading = false;
      notifyListeners();
      ShowDialogs.showToast("Please check internet connection");
      return;
    }

    try {
      var requestBody = createRequestBody(categoryIds);

      await APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.categoryIdsWiseCourses,
        (response) {
          print("response category");
          print(response);

          catWise.CategoryWiseResponse category1WiseList = response;
          categoryWiseList = category1WiseList.data;
          print("categoryWiseList.data.length");
          print(category1WiseList.data.length);
          _isCategoryWiseLoading = false;
          notifyListeners();
        },
        (error) {
          _isCategoryWiseLoading = false;
          notifyListeners();
          ShowDialogs.showToast("Server Not Responding");
        },
        jsonval: requestBody,
      );
    } catch (e) {
      _isCategoryWiseLoading = false;
      notifyListeners();
      ShowDialogs.showToast("Something went wrong");
    }
  }
  void saveCategoryCourse(int index) {
      final providercourse =
          Provider.of<CoursesProvider>(routeGlobalKey.currentContext!, listen: false);
          print(categoryWiseList[index].courseId);
         providercourse.savedCourseAPI(categoryWiseList[index].courseId);
  categoryWiseList[index].savedFlag = true;
  notifyListeners(); // Notify UI to rebuild
}

void unSaveCategoryCourse(int index) {
   final providercourse =
   Provider.of<CoursesProvider>(routeGlobalKey.currentContext!, listen: false);
         providercourse.unSavedCourseAPI(categoryWiseList[index].courseId);
  categoryWiseList[index].savedFlag = false;
  notifyListeners(); // Notify UI to rebuild
}
}
