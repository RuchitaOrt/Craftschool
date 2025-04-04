import 'package:craft_school/dto/AllCoursesResponse.dart';
import 'package:craft_school/dto/GetCourseReviewResponse.dart' as review;
import 'package:craft_school/dto/LogoutResponse.dart';
import 'package:craft_school/dto/MycourseResponse.dart' as mycourse;
import 'package:craft_school/dto/OtherCoursesResponse.dart' as othercourses;
import 'package:craft_school/dto/ParticularCoursesResponse.dart'
    as particularCourse;
import 'package:craft_school/dto/SavedCourseListResponse.dart' as savedCourse;
import 'package:craft_school/dto/SavedCourseResponse.dart';

import 'package:craft_school/main.dart';
import 'package:craft_school/screens/Landing_Screen.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/GlobalLists.dart';
import 'package:craft_school/utils/ShowDialog.dart';

import 'package:craft_school/utils/internetConnection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoursesProvider with ChangeNotifier {
  List<Map<String, dynamic>> courseCoveredTopics = [
    {
      'title': '75+ countries,live courses,& original series',
    },
    {
      'title': 'Audio-only lessons',
    },
    {
      'title': 'Download and watch offline (Select Plans)',
    },
    {
      'title': 'Downloadable class guides for every class',
    },
    {
      'title': 'Watch on Mobile,Tv and Desktop Devices',
    },
    {
      'title': 'New classes added every month',
    },
    // Add more static items as needed
  ];
  bool _isExpanded = false;

  bool get isExpanded => _isExpanded;

  void toggleExpansion() {
    _isExpanded = !_isExpanded;
    notifyListeners(); // Notify all listeners (widgets) that the state has changed
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isBuyNowExpanded = false;

  // Function to toggle the expanded/collapsed state
  void toggleBuyNowExpansion() {
    isBuyNowExpanded = !isBuyNowExpanded;
    notifyListeners(); // Notify listeners to rebuild the widget
  }

  final List<Map<String, String>> chipPlanData = [
    {'label': 'Individual', 'image': ''},
    {'label': 'Subscription', 'image': ''},
  ];
  String? selectedChip = "Individual";
  void onSingleChipSelected(String? label) {
    selectedChip = label; // Update the selected chip
    // if(label=="Google")
    // {
    //   signInWithGoogle();
    // }
    notifyListeners();
  }

  // Pagination variables
  int _start = 0;
  final int _length = 6; // Number of blogs per fetch
  int totalLength = 0;
  List<Datum> _courseList = [];

  // Getter for data
  List<Datum> get courseList => _courseList;
  set courseList(List<Datum> data) {
    _courseList = data;
    notifyListeners();
  }

  // Method to create request body
  createRequestBody() {
    return {
      "start": _start,
      "length": _length,
    };
  }

  // API call to get blogs
  Future<void> getCourseAPI() async {
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createRequestBody();

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.getAllCourses,
        (response) async {
          AllCoursesResponse resp = response;

          if (resp.status == true) {
            // Append the new blogs to the list
            _courseList.addAll(resp.data);
            totalLength = int.parse(resp.total);
            _start += _length; // Update the start for next fetch
            notifyListeners();
          }
        },
        (error) {
          // Handle error case
          print('Error getAllCourses: $error');
          ShowDialogs.showToast("Server Not Responding");
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }

  createDetailRequestBody(String slug) {
    return {"course_slug": slug, "customer_id": GlobalLists.customerID};
  }

  List<particularCourse.Datum> _courseDetailList = [];

  // Getter for data
  List<particularCourse.Datum> get courseDetailList => _courseDetailList;
  set courseDetailList(List<particularCourse.Datum> data) {
    _courseDetailList = data;
    notifyListeners();
  }

  bool _iscourseDetailLoading = false;
  bool get iscourseDetailLoading => _iscourseDetailLoading;

  set iscourseDetailLoading(bool value) {
    _iscourseDetailLoading = value;
    notifyListeners();
  }

  Future<void> getCourseDetailAPI(String slug) async {
    iscourseDetailLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createDetailRequestBody(slug);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.particularCourseDetailsBySlug,
        (response) async {
          particularCourse.ParticularCoursesResponse resp = response;

          if (resp.status == true) {
            // Append the new blogs to the list
            _courseDetailList = resp.data;
            iscourseDetailLoading = false;

            notifyListeners();
          }
        },
        (error) {
          // Handle error case
          print('Error particularCourseDetailsBySlug: $error');
          ShowDialogs.showToast("Server Not Responding");
          iscourseDetailLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      iscourseDetailLoading = false;
      return Future.error("No Internet Connection");
    }
  }

  int _startothercourses = 0;
  final int _lengthothercourses = 3; // Number of blogs per fetch
  int totalLengthothercourses = 0;
  List<othercourses.Datum> _othercourseList = [];

  // Getter for data
  List<othercourses.Datum> get othercourseList => _othercourseList;
  set othercourseList(List<othercourses.Datum> data) {
    _othercourseList = data;
    notifyListeners();
  }

  // Method to create request body
  createOtherRequestBody() {
    return {
      "start": _startothercourses,
      "length": _lengthothercourses,
    };
  }

  bool _isOtherLoading = false;
  bool get isOtherLoading => _isOtherLoading;

  set isOtherLoading(bool value) {
    _isOtherLoading = value;
    notifyListeners();
  }

  // API call to get blogs
  Future<void> getOtherCourseAPI() async {
    print("getOtherCourseAPI");
    isOtherLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createOtherRequestBody();

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.everySkillYouNeed,
        (response) async {
          othercourses.OtherCoursesResponse resp = response;

          if (resp.status == true) {
            // Append the new blogs to the list
            _othercourseList.addAll(resp.data);
            print("_othercourseList.length");
            print(_othercourseList.length);
            totalLengthothercourses = int.parse(resp.total);
            _startothercourses +=
                _lengthothercourses; // Update the start for next fetch
            isOtherLoading = false;
            notifyListeners();
          }
        },
        (error) {
          // Handle error case
          print('Error everySkillYouNeed: $error');
          ShowDialogs.showToast("Server Not Responding");
          isOtherLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isOtherLoading = false;
      return Future.error("No Internet Connection");
    }
  }

  List<savedCourse.Datum> _savedcourseList = [];

  // Getter for data
  List<savedCourse.Datum> get savedcourseList => _savedcourseList;
  set savedcourseList(List<savedCourse.Datum> data) {
    _savedcourseList = data;
    notifyListeners();
  }

  createSaveCourseRequestBody(String courseId) {
    return {
      "course_id": courseId,
    };
  }

  createSavedCourseRequestBody(String categoryId) {
    return {"category_id": categoryId};
  }

  bool _isSavedLoading = false;
  bool get isSavedLoading => _isSavedLoading;

  set isSavedLoading(bool value) {
    _isSavedLoading = value;
    notifyListeners();
  }

  Future<void> getSavedCourseAPI(String categoryId) async {
    _savedcourseList = [];
    isSavedLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createSavedCourseRequestBody(categoryId);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.getSavedCoursesList,
        (response) async {
          savedCourse.SavedCourseListResponse resp = response;

          if (resp.status == true) {
            // Append the new blogs to the list
            _savedcourseList.addAll(resp.data);
            print("_savedcourseList.length");
            print(_savedcourseList.length);
            isSavedLoading = false;
            notifyListeners();
          }
        },
        (error) {
          // Handle error case
          print('Error getSavedCoursesList: $error');
          ShowDialogs.showToast("Server Not Responding");
          isSavedLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isSavedLoading = false;
      return Future.error("No Internet Connection");
    }
  }

//savedcourse

  Future<void> savedCourseAPI(String courseID) async {
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createSaveCourseRequestBody(courseID);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.saveCourse,
        (response) async {
          SavedCoursesResponse resp = response;

          if (resp.status == true) {
            ShowDialogs.showToast(resp.message);
          }
        },
        (error) {
          // Handle error case
          print('Error saveCourse: $error');
          // ShowDialogs.showToast("Server Not Responding");
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }
//unsavedcourse

  Future<void> unSavedCourseAPI(String courseID) async {
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createSaveCourseRequestBody(courseID);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.unSaveCourse,
        (response) async {
          SavedCoursesResponse resp = response;

          if (resp.status == true) {
            ShowDialogs.showToast(resp.message);
          }
        },
        (error) {
          // Handle error case
          print('Error unSaveCourse: $error');
          // ShowDialogs.showToast("Server Not Responding");
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }
//my course

  bool _ismycourseLoading = false;
  bool get ismycourseLoading => _ismycourseLoading;

  set ismycourseLoading(bool value) {
    _ismycourseLoading = value;
    notifyListeners();
  }

  createMyCourseRequestBody(
      String categoryid, String completionstatus, String masterid) {
    return {
      "category_id": categoryid,
      "completion_status": completionstatus,
      "master_id": masterid
    };
  }

  List<mycourse.Datum> _mycourseList = [];

  // Getter for data
  List<mycourse.Datum> get mycourseList => _mycourseList;
  set mycourseList(List<mycourse.Datum> data) {
    _mycourseList = data;
    notifyListeners();
  }

  Future<void> getMyCourseAPI(
      String categoryid, String completionstatus, String masterid) async {
    ismycourseLoading = true;
    _mycourseList = [];
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody =
          createMyCourseRequestBody(categoryid, completionstatus, masterid);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.mycourse,
        (response) async {
          mycourse.MycourseResponse resp = response;
          print(API.mycourse);
          print(jsonbody);
          print("mycourse api callled");
          if (resp.status == true) {
            // Append the new blogs to the list
            _mycourseList.addAll(resp.data);
            print(_mycourseList.length);
            ismycourseLoading = false;
            notifyListeners();
          }
        },
        (error) {
          // Handle error case
          print('Error mycourse: $error');
          ShowDialogs.showToast("Server Not Responding");
          ismycourseLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      ismycourseLoading = false;
      return Future.error("No Internet Connection");
    }
  }

  bool _isReviewViewed = false;

  bool get isReviewViewed => _isReviewViewed;

  void reviewExpansion() {
    _isReviewViewed = !isReviewViewed;
    notifyListeners(); // Notify all listeners (widgets) that the state has changed
  }

  Map<String, dynamic> createReviewRequestBody(
      String coureId, String review, String rating) {
    return {"course_id": coureId, "comments": review, "rating": rating};
  }

  submitReviewAPI(String coureId, String review, String rating) async {
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createReviewRequestBody(coureId, review, rating);
      print(jsonbody);

      APIManager().apiRequest(routeGlobalKey.currentContext!, API.post_reviews,
          (response) async {
        CommonResponse resp = response;
        // if (response['status'] == true) {
        if (resp.status == true) {
          ShowDialogs.showToast(resp.message);
        }
      }, (error) {
        print('ERR SignUpResponse is $error');

        ShowDialogs.showToast("Server Not Responding");
      }, jsonval: jsonbody);
    } else {
      /// Navigator.of(_keyLoader.currentContext).pop();
      ShowDialogs.showToast("Please check internet connection");
    }
  }

  double _rating = 0; // Private variable

  // Getter
  double get rating => _rating;

  // Setter
  set rating(double value) {
    _rating = value;
  }

  void saveOtherCourse(int index) {
    othercourseList[index].savedFlag = true;
    notifyListeners(); // Notify UI to rebuild
  }

  void unSaveOtherCourse(int index) {
    othercourseList[index].savedFlag = false;
    notifyListeners(); // Notify UI to rebuild
  }

  void saveAllCourse(int index) {
    courseList[index].savedFlag = true;
    notifyListeners(); // Notify UI to rebuild
  }

  void unSaveAllCourse(int index) {
    courseList[index].savedFlag = false;
    notifyListeners(); // Notify UI to rebuild
  }

  void saveParticularCourse() {
    final providercourse = Provider.of<CoursesProvider>(
        routeGlobalKey.currentContext!,
        listen: false);
    providercourse.savedCourseAPI(courseDetailList[0].courseData[0].courseId);
    courseDetailList[0].courseData[0].savedFlag = true;
    notifyListeners(); // Notify UI to rebuild
  }

  createCourseReviewRequestBody(String courseId) {
    return {"start": 0, "length": 0, "sort": "ASC", "course_id": courseId};
  }

//course review
  List<review.Datum> _courseReviewList = [];

  // Getter for data
  List<review.Datum> get courseReviewList => _courseReviewList;
  set courseReviewList(List<review.Datum> data) {
    _courseReviewList = data;
    notifyListeners();
  }

  bool _isReviewcourseLoading = false;
  bool get isReviewcourseLoading => _isReviewcourseLoading;

  set isReviewcourseLoading(bool value) {
    _isReviewcourseLoading = value;
    notifyListeners();
  }

  Future<void> getCourseReviewAPI(String courseId) async {
    isReviewcourseLoading = true;
    courseReviewList = [];
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createCourseReviewRequestBody(courseId);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.getCourseReviews,
        (response) async {
          review.GetCourseReviewResponse resp = response;

          if (resp.status == true) {
            // Append the new blogs to the list
            courseReviewList.addAll(resp.data);
            print(_mycourseList.length);
            isReviewcourseLoading = false;
            notifyListeners();
          }
        },
        (error) {
          // Handle error case
          print('Error getCourseReviews: $error');
          ShowDialogs.showToast("Server Not Responding");
          isReviewcourseLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isReviewcourseLoading = false;
      return Future.error("No Internet Connection");
    }
  }
}
