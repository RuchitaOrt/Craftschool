
import 'package:craft_school/dto/MasterDetailClassResponse.dart';
import 'package:craft_school/dto/MasterListResponse.dart';
import 'package:craft_school/dto/TrendingClassResponse.dart' as trendingClass;
import 'package:craft_school/dto/TrendingMasterResponse.dart' as trendingMaster;

import 'package:craft_school/main.dart';
import 'package:craft_school/providers/CoursesProvider.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';

import 'package:craft_school/utils/internetConnection.dart';
import 'package:craft_school/widgets/TrendingSkill.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MasterAllProvider with ChangeNotifier {

   bool _isLoading = false;
  
  // Loading state
  bool get isLoading => _isLoading;

  // Set loading state
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
 
List<Datum> _masterAllData = [];

  // Getter for serviceData
  List<Datum> get masterAllData => _masterAllData;

  // Setter for serviceData
  set masterAllData(List<Datum> data) {
    _masterAllData = data;
    notifyListeners(); // Notify listeners to update the UI
  }
  // API call for home screen data
  Future<void> getMasterAllAPI() async {
    // Set loading to true when the API request starts
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = "";
      
      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.master_list,
        (response) async {
          MasterListResponse resp = response;

          if (resp.status == true) {
           masterAllData=resp.data;
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
List<trendingMaster.Datum> _trendingMasterData = [];

  // Getter for serviceData
  List<trendingMaster.Datum> get trendingMasterData => _trendingMasterData;

  // Setter for serviceData
  set trendingMasterData(List<trendingMaster.Datum> data) {
    _trendingMasterData = data;
    notifyListeners(); // Notify listeners to update the UI
  }

    bool _istrendingMasterLoading = false;
  
  // Loading state
  bool get istrendingMasterLoading => _istrendingMasterLoading;

  // Set loading state
  set istrendingMasterLoading(bool value) {
    _istrendingMasterLoading = value;
    notifyListeners();
  }
  Future<void> getTrendingMasterAPI() async {
    // Set loading to true when the API request starts
    istrendingMasterLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = "";
      
      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.trendingMaster,
        (response) async {
          trendingMaster.TrendingMasterResponse resp = response;

          if (resp.status == true) {
           trendingMasterData=resp.data;
           print("trendingMasterData ${trendingMasterData.length}");
            istrendingMasterLoading = false;
          }
        },
        (error) {
          // Handle error case
          print('ERR msg is $error');
          ShowDialogs.showToast("Server Not Responding");

          // Set loading to false in case of an error
          istrendingMasterLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");

      // Set loading to false when no internet
      istrendingMasterLoading = false;
      return Future.error("No Internet Connection");
    }
  }
  List<trendingClass.Datum> _trendingClassData = [];

  // Getter for serviceData
  List<trendingClass.Datum> get trendingClassData => _trendingClassData;

  // Setter for serviceData
  set trendingClassData(List<trendingClass.Datum> data) {
    _trendingClassData = data;
    notifyListeners(); // Notify listeners to update the UI
  }
  Future<void> getTrendingClassAPI() async {
    // Set loading to true when the API request starts
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = "";
      
      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.trendingClass,
        (response) async {
          trendingClass.TrendingClassResponse resp = response;

          if (resp.status == true) {
           trendingClassData=resp.data!;
         
            isLoading = false;
            notifyListeners();
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
   bool _isMasterDetailLoading = false;
  
  // Loading state
  bool get isMasterDetailLoading => _isMasterDetailLoading;

  // Set loading state
  set isMasterDetailLoading(bool value) {
    _isMasterDetailLoading = value;
    notifyListeners();
  }
   List<MasterDatum> _masterDataDetial = [];
  List<MasterCourse> _masterCourses = [];

  // Getter for masterData
  List<MasterDatum> get masterDataDetail => _masterDataDetial;

  // Setter for masterData
  set masterDataDetail(List<MasterDatum> newData) {
    _masterDataDetial = newData;
  }

  // Getter for masterCourses
  List<MasterCourse> get masterCourses => _masterCourses;

  // Setter for masterCourses
  set masterCourses(List<MasterCourse> newCourses) {
    _masterCourses = newCourses;
  }

 
  createRequestBody(String slug) {
    return 
    { 
   "master_slug":slug
    };
  }
   Future<void> getMasterDetailBySlugAPI(String slug) async {
    // Set loading to true when the API request starts
    isMasterDetailLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createRequestBody(slug);
      
      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.MasterDetailBySlug,
        (response) async {
        MasterDetailClassResponse resp = response;

          if (resp.status == true) {
           masterDataDetail=resp.masterData;
           masterCourses=resp.masterCourses;
            isMasterDetailLoading = false;
          }
        },
        (error) {
          // Handle error case
          print('ERR msg is $error');
          ShowDialogs.showToast("Server Not Responding");

          // Set loading to false in case of an error
          isMasterDetailLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");

      // Set loading to false when no internet
      isMasterDetailLoading = false;
      return Future.error("No Internet Connection");
    }
  }


   void saveTrendingCourse(int index) {
      final providercourse =
          Provider.of<CoursesProvider>(routeGlobalKey.currentContext!, listen: false);
         providercourse.savedCourseAPI(trendingClassData[index].courseId!);
  trendingClassData[index].savedFlag = true;
  notifyListeners(); // Notify UI to rebuild
}

void unsaveTrendingCourse(int index) {
   final providercourse =
   Provider.of<CoursesProvider>(routeGlobalKey.currentContext!, listen: false);
         providercourse.unSavedCourseAPI(trendingClassData[index].courseId!);
  trendingClassData[index].savedFlag = false;
  notifyListeners(); // Notify UI to rebuild
}


//master courses
 void savemasterCourse(int index) {
      final providercourse =
          Provider.of<CoursesProvider>(routeGlobalKey.currentContext!, listen: false);
         providercourse.savedCourseAPI(masterCourses[index].courseId!);
  masterCourses[index].savedFlag = true;
  notifyListeners(); // Notify UI to rebuild
}

void unsaveMasterCourse(int index) {
   final providercourse =
   Provider.of<CoursesProvider>(routeGlobalKey.currentContext!, listen: false);
         providercourse.unSavedCourseAPI(masterCourses[index].courseId!);
  masterCourses[index].savedFlag = false;
  notifyListeners(); // Notify UI to rebuild
}
}

