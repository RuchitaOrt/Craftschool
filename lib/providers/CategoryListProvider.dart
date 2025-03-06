
import 'dart:convert';

import 'package:craft_school/dto/CategoryListResponse.dart';
import 'package:craft_school/dto/CategoryWiseResponse.dart' as catWise;
import 'package:craft_school/main.dart';
import 'package:flutter/material.dart';

import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/internetConnection.dart';
import 'package:http/http.dart' as http;

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

// Future<void> getCategoryWiseList(List<int> categoryIds) async {
//   _isCategoryWiseLoading = true;
//   notifyListeners();

//   var status1 = await ConnectionDetector.checkInternetConnection();

//   if (status1) {
//     // Create the request body with the categoryIds
//     var jsonbody = {
//       "category_ids": [2],  // Pass the categoryIds list here
//       "start": 0,
//       "length": 0
//     };
// print(jsonbody);
//     var headers = {
//       // 'Accept': 'application/json',
//       // 'x-api-key': 'IjMgJzUSIikuLi1yYAFiMTMuKyQiNWQfZ2s0MiQzeHl2YGAyN',  // Ensure your API key is correct
//     };

//     try {
//       // Send POST request with the list of category_ids
//       var response = await http.post(
//         Uri.parse("http://uat-craftschool.onerooftechnologiesllp.com/categoryIdsWiseCourses"),
//         // headers: headers,
//         body: json.encode(jsonbody),  // Encode the body as JSON
//       );
//       print("cateforywise");
//      print(response.body);
//       if (response.statusCode == 200) {
//         // Successfully received the response
//         var responseBody = json.decode(response.body);  // Decode the response JSON
//         catWise.CategoryWiseResponse resp = catWise.CategoryWiseResponse.fromJson(responseBody);
//         categoryWiseList = resp.data;

//         _isCategoryWiseLoading = false;
//         notifyListeners();
//       } else {
//         // Handle error response
//         _isCategoryWiseLoading = false;
//         notifyListeners();
//         ShowDialogs.showToast("Error: ${response.statusCode}, ${response.body}");
//       }
//     } catch (e) {
//       // Handle exception
//       _isCategoryWiseLoading = false;
//       notifyListeners();
//       ShowDialogs.showToast("Server Not Responding Categoru");
//     }
//   } else {
//     // If no internet connection
//     _isCategoryWiseLoading = false;
//     notifyListeners();
//     ShowDialogs.showToast("Please check internet connection");
//   }
// }
    Map<String, dynamic> createRequestBody(var categoryIds) {
    return 
    { 
     "category_ids":categoryIds,
    "start":"0",
    "length":"0"
    };
  }
// Future<void> getCategoryWiseList(List<int> categoryIds) async {
//   var url = 'http://uat-craftschool.onerooftechnologiesllp.com/categoryIdsWiseCourses';

//   // Ensure category_ids is not empty, else use a default value for testing
//   var requestBody = {
//     "category_ids": categoryIds.isEmpty ? [2] : categoryIds,  // Default to [2] if empty
//     "start": 0,
//     "length": 0
//   };

//   // Set headers for the request
//   var headers = {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//     // Add any other headers (e.g., API keys) if required
//   };

//   // Prepare the request
//   var request = http.Request('POST', Uri.parse(url));
//   request.body = json.encode(requestBody);  // Encode the body to JSON format
//   request.headers.addAll(headers);  // Add headers to the request

//   try {
//     // Send the request
//     http.StreamedResponse response = await request.send();

//     // Check the status code
//     if (response.statusCode == 200) {
//       // If successful, decode the response body
//       var responseBody = await response.stream.bytesToString();
//       var responseJson = json.decode(responseBody);
//       print("Response: $responseJson");
//       // Handle your successful response here, e.g., map data to model
//     } else {
//       // If failed, print the reason phrase
//       print("Error: ${response.reasonPhrase}");
//     }
//   } catch (e) {
//     // Catch any exceptions (e.g., no internet, timeout, etc.)
//     print("Error: $e");
//   }
// }
   Future<void> getCategoryWiseList(var categoryIds) async {
    _isCategoryWiseLoading = true;
    notifyListeners();

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      var jsonbody = 
      createRequestBody(categoryIds);
      await APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.categoryIdsWiseCourses,
        (response) {
          catWise.CategoryWiseResponse resp = response;
          categoryWiseList = resp.data;
         
          _isCategoryWiseLoading = false;
          notifyListeners();
        },
        (error) {
          _isCategoryWiseLoading = false;
         
          notifyListeners();
          ShowDialogs.showToast("Server Not Responding");
        },
        jsonval: jsonbody,
      );
    } else {
      _isCategoryWiseLoading = false;
     
      notifyListeners();
      ShowDialogs.showToast("Please check internet connection");
    }
  }
}
