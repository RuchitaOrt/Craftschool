import 'dart:convert';
import 'dart:io';

import 'package:craft_school/dto/AllCoursesResponse.dart';
import 'package:craft_school/dto/BlogDetailResponse.dart';
import 'package:craft_school/dto/BlogResponse.dart';
import 'package:craft_school/dto/CategoryListResponse.dart';
import 'package:craft_school/dto/CategoryWiseResponse.dart';
import 'package:craft_school/dto/CheckSubscriptionIndividualFlowWiseInfoResponse.dart';
import 'package:craft_school/dto/CommentListResponse.dart';
import 'package:craft_school/dto/CustomerCategoryListResponse.dart';
import 'package:craft_school/dto/CustomerIdCategoryWiseResponse.dart';
import 'package:craft_school/dto/CustomerInfoResponse.dart';
import 'package:craft_school/dto/FAQResponse.dart';
import 'package:craft_school/dto/FetchCustomerInfoResponse.dart';
import 'package:craft_school/dto/ForgetpasswordResponse.dart';
import 'package:craft_school/dto/GetAllCommunityResponse.dart';
import 'package:craft_school/dto/GetAllPlanResponse.dart';
import 'package:craft_school/dto/GetCourseReviewResponse.dart';
import 'package:craft_school/dto/GetLoggedInDevicesResponse.dart';
import 'package:craft_school/dto/GetServicesResponse.dart';
import 'package:craft_school/dto/GetmembershipPlanResponse.dart';
import 'package:craft_school/dto/JoinFestivalResponse.dart';
import 'package:craft_school/dto/LandingScreenResponse.dart';
import 'package:craft_school/dto/LoginResponse.dart';
import 'package:craft_school/dto/LogoutResponse.dart';
import 'package:craft_school/dto/MasterDetailClassResponse.dart';
import 'package:craft_school/dto/MasterListResponse.dart';
import 'package:craft_school/dto/MycourseResponse.dart';
import 'package:craft_school/dto/OtherCoursesResponse.dart';
import 'package:craft_school/dto/ParticularCoursesResponse.dart';
import 'package:craft_school/dto/PayNowResponse.dart';
import 'package:craft_school/dto/SavedCourseListResponse.dart';
import 'package:craft_school/dto/SavedCourseResponse.dart';
import 'package:craft_school/dto/SavedPostListResponse.dart';
import 'package:craft_school/dto/SeachListResponse.dart';
import 'package:craft_school/dto/SignUpResponse.dart';
import 'package:craft_school/dto/TestimonialResponse.dart';
import 'package:craft_school/dto/TrendingClassResponse.dart';
import 'package:craft_school/dto/TrendingMasterResponse.dart';
import 'package:craft_school/dto/UpcomingCourseResponse.dart';
import 'package:craft_school/dto/UpdatepasswordResponse.dart';
import 'package:craft_school/utils/AppEror.dart';
import 'package:craft_school/utils/SPManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum API {
  signUp,
  categoryList,
  login,
  logout,
  forgetPassword,
  updatePassword,
  homeScreen,
  getAllPlan,
  getCraftschoolServices,
  testimonials,
  customerSignupCategoriesList,
  customercategoryIdsWiseCourses,
  categoryIdsWiseCourses,
  master_list,
  trendingMaster,
  trendingClass,
  MasterDetailBySlug,
  settingCustomerInfo,
  fetchCustomerInfo,
  updatePersonalInfo,
  updateCustomerPassword,
  blogs,
  getParticularBlogDetails,
  getAllCourses,
  particularCourseDetailsBySlug,
  everySkillYouNeed,
  getjoinflimfestival,
  getSavedCoursesList,
  saveCourse,
  unSaveCourse,
  get_all_community_post,
  save_community_post,
  report_community_post,
  delete_community_post,
  like_community_post,
  community_post_comment,
  dislike_community_post,
  unsave_community_post,
  delete_community_post_comment,
  get_community_post_details,
  likeCommunityPostComment,
  unlikeCommunityPostComment,
  get_all_saved_community_post,
  mycourse,
  checkSubscriptionIndividualFlowWiseInfo,
  storecoursetopicwisewatchtime,
  fetchCustomerloginDeviceInfo,
  membership,
  deleteCommunityPostMedia,
  customerProcessSubscription,
  customerUpdatePaymentResponse,
  getUpcomingCourses,
  contact_us,
  storeCustomerFlimFestival,
  news_letter,
  post_reviews,
  faq,
  getCourseReviews,
  searchCourseMaster
  
}

enum HTTPMethod { GET, POST, PUT, DELETE }

typedef successCallback = void Function(dynamic response);
typedef progressCallback = void Function(int progress);
typedef failureCallback = void Function(AppError error);

class APIManager {
  static Duration? timeout;
  static String? token;
  static String? baseURL;
  static String? apiVersion;
  var taskId;

  APIManager._privateConstructor();
  static final APIManager _instance = APIManager._privateConstructor();

  factory APIManager() {
    return _instance;
  }
  static String addCommunityPost = "${baseURL!}/add_community_post";
  static String updatePersonalInfo = "${baseURL!}/updatePersonalInfo";
  static String editCommunityPost = "${baseURL!}/update_community_post";
  static String careerSave = "${baseURL!}/Career_Save";
  var url;
  void loadConfiguration(String configString) {
    Map config = jsonDecode(configString);
    var env = config['environment'];
    baseURL = config[env]['hostUrl'];
    apiVersion = config['version'];
    timeout = Duration(seconds: config[env]['timeout']);
    print('load config' + configString);
  }

  void setToken(String value) {
    token = value;
  }

  String apiBaseURL() {
    return baseURL!;
  }

  Future<String> apiEndPoint(API api) async {
    var apiPathString = "";

    switch (api) {
      case API.signUp:
        apiPathString = "/sign_up";
        break;
      case API.categoryList:
        apiPathString = "/categories";
        break;
      case API.login:
        apiPathString = "/login";
        break;
      case API.logout:
        apiPathString = "/logout";
        break;
      case API.forgetPassword:
        apiPathString = "/forgetPassword";
        break;
      case API.updatePassword:
        apiPathString = "/updatePassword";
        break;
      case API.homeScreen:
        apiPathString = "/flutterHomePage";
        break;
      case API.getAllPlan:
        apiPathString = "/getAllPlans";
        break;
      case API.getCraftschoolServices:
        apiPathString = "/getCraftschoolServices";
        break;
      case API.testimonials:
        apiPathString = "/testimonials";
        break;
      case API.customerSignupCategoriesList:
        apiPathString = "/customerSignupCategoriesList";
        break;
      case API.customercategoryIdsWiseCourses:
        apiPathString = "/customercategoryIdsWiseCourses";
        break;
      case API.categoryIdsWiseCourses:
        apiPathString = "/categoryIdsWiseCourses";
        break;
      case API.master_list:
        apiPathString = "/master_list";
        break;
      case API.trendingMaster:
        apiPathString = "/trendingMaster";
        break;
      case API.trendingClass:
        apiPathString = "/trendingClass";
        break;
      case API.MasterDetailBySlug:
        apiPathString = "/MasterDetailBySlug";
        break;
      case API.settingCustomerInfo:
        apiPathString = "/settingCustomerInfo";
        break;
      case API.fetchCustomerInfo:
        apiPathString = "/fetchCustomerInfo";
        break;
      case API.updateCustomerPassword:
        apiPathString = "/updateCustomerPassword";
        break;
      case API.updatePersonalInfo:
        apiPathString = "/updatePersonalInfo";
        break;
      case API.blogs:
        apiPathString = "/blogs";
        break;
      case API.getParticularBlogDetails:
        apiPathString = "/getParticularBlogDetails";
        break;
      case API.getAllCourses:
        apiPathString = "/getAllCourses";
        break;
      case API.particularCourseDetailsBySlug:
        apiPathString = "/particularCourseDetailsBySlug";
        break;
      case API.everySkillYouNeed:
        apiPathString = "/everySkillYouNeed";
        break;
      case API.getjoinflimfestival:
        apiPathString = "/getjoinflimfestival";
        break;
      case API.getSavedCoursesList:
        apiPathString = "/getSavedCoursesList";
        break;
      case API.saveCourse:
        apiPathString = "/saveCourse";
        break;
      case API.unSaveCourse:
        apiPathString = "/unSaveCourse";
        break;
      case API.get_all_community_post:
        apiPathString = "/get_all_community_post";
        break;
      //
      case API.save_community_post:
        apiPathString = "/save_community_post";
        break;
      case API.report_community_post:
        apiPathString = "/report_community_post";
        break;

      case API.delete_community_post:
        apiPathString = "/delete_community_post";
        break;
      case API.like_community_post:
        apiPathString = "/like_community_post";
        break;
      case API.community_post_comment:
        apiPathString = "/community_post_comment";
        break;

      case API.dislike_community_post:
        apiPathString = "/dislike_community_post";
        break;
      case API.unsave_community_post:
        apiPathString = "/unsave_community_post";
        break;
      case API.delete_community_post_comment:
        apiPathString = "/delete_community_post_comment";
        break;
      case API.get_community_post_details:
        apiPathString = "/get_community_post_details";
        break;
      case API.likeCommunityPostComment:
        apiPathString = "/likeCommunityPostComment";
        break;
      case API.unlikeCommunityPostComment:
        apiPathString = "/unlikeCommunityPostComment";
        break;
      case API.get_all_saved_community_post:
        apiPathString = "/get_all_saved_community_post";
        break;
      case API.mycourse:
        apiPathString = "/mycourse";
        break;
      case API.membership:
        apiPathString = "/membership";
        break;
        case API.checkSubscriptionIndividualFlowWiseInfo:
        apiPathString = "/checkSubscriptionIndividualFlowWiseInfo";
        break;
         case API.fetchCustomerloginDeviceInfo:
        apiPathString = "/fetchCustomerloginDeviceInfo";
        break;
          case API.storecoursetopicwisewatchtime:
        apiPathString = "/storecoursetopicwisewatchtime";
        break;
         case API.deleteCommunityPostMedia:
        apiPathString = "/deleteCommunityPostMedia";
        break;
          case API.customerProcessSubscription:
        apiPathString = "/customerProcessSubscription";
        break;
         case API.customerUpdatePaymentResponse:
        apiPathString = "/customerUpdatePaymentResponse";
        break;
         case API.getUpcomingCourses:
        apiPathString = "/getUpcomingCourses";
        break;
         case API.contact_us:
        apiPathString = "/contact_us";
        break;
         case API.storeCustomerFlimFestival:
        apiPathString = "/storeCustomerFlimFestival";
        break;
         case API.news_letter:
        apiPathString = "/news_letter";
        break;
         case API.post_reviews:
        apiPathString = "/post_reviews";
        break;
        case API.faq:
        apiPathString = "/faq";
        break;
         case API.getCourseReviews:
        apiPathString = "/getCourseReviews";
        break;
          case API.searchCourseMaster:
        apiPathString = "/searchCourseMaster";
        break;

      default:
        apiPathString = "/Login";
    }
    print(apiBaseURL());

    return this.apiBaseURL() + apiPathString;
  }

  HTTPMethod apiHTTPMethod(API api) {
    HTTPMethod method;
    switch (api) {
      case API.categoryList:
      case API.getAllPlan:
      case API.getCraftschoolServices:
      case API.testimonials:
      case API.customerSignupCategoriesList:
      case API.trendingMaster:
      case API.trendingClass:
      case API.getjoinflimfestival:
      case API.get_all_saved_community_post:
      case API.faq:
        method = HTTPMethod.GET;
        break;

      default:
        method = HTTPMethod.POST;
    }
    return method;
  }

  String classNameForAPI(API api) {
    String className;
    switch (api) {
      case API.signUp:
        className = "SignUpResponse";
        break;
      case API.categoryList:
        className = "CategoryListResponse";
        break;
      case API.login:
        className = "LoginResponse";
        break;
      case API.logout:
      case API.updatePersonalInfo:
      case API.updateCustomerPassword:

       case API.storeCustomerFlimFestival:
       case API.news_letter:
       case API.post_reviews:
        className = "CommonResponse";
        break;
      case API.forgetPassword:
        className = "ForgetpasswordResponse";
        break;
      case API.updatePassword:
        className = "UpdatepasswordResponse";
        break;
      case API.homeScreen:
        className = "LandingScreenResponse";
        break;
      case API.getAllPlan:
        className = "GetAllPlanResponse";
        break;
      case API.getCraftschoolServices:
        className = "GetServicesResponse";
        break;
      case API.testimonials:
        className = "TestimonialResponse";
        break;
      case API.customerSignupCategoriesList:
        className = "CustomerCategoryListResponse";
        break;
      case API.customercategoryIdsWiseCourses:
        className = "CustomerIdCategoryWiseResponse";
        break;
      case API.categoryIdsWiseCourses:
        className = "CategoryWiseResponse";
        break;
      case API.master_list:
        className = "MasterListResponse";
        break;
      case API.trendingMaster:
        className = "TrendingMasterResponse";
        break;
      case API.trendingClass:
        className = "TrendingClassResponse";
        break;
      case API.MasterDetailBySlug:
        className = "MasterDetailClassResponse";
        break;
      case API.settingCustomerInfo:
        className = "CustomerInfoResponse";
        break;
      case API.fetchCustomerInfo:
        className = "FetchCustomerInfoResponse";
        break;

      case API.blogs:
        className = "BlogResponse";
        break;
      case API.getParticularBlogDetails:
        className = "BlogDetailResponse";
        break;
      case API.getAllCourses:
        className = "AllCoursesResponse";
        break;
      case API.particularCourseDetailsBySlug:
        className = "ParticularCoursesResponse";
        break;
      case API.everySkillYouNeed:
        className = "OtherCoursesResponse";
        break;
      case API.getjoinflimfestival:
        className = "JoinFestivalResponse";
        break;
      case API.getSavedCoursesList:
        className = "SavedCourseListResponse";
        break;
      case API.saveCourse:
      case API.unSaveCourse:
      case API.save_community_post:
      case API.report_community_post:
      case API.delete_community_post:
      case API.like_community_post:
      case API.community_post_comment:
      case API.dislike_community_post:
      case API.unsave_community_post:
      case API.delete_community_post_comment:
      case API.likeCommunityPostComment:
      case API.unlikeCommunityPostComment:
      case API.storecoursetopicwisewatchtime:
      case API.deleteCommunityPostMedia:
      case API.customerUpdatePaymentResponse:

       case API.contact_us:
        className = "SavedCourseResponse";
        break;
      case API.get_all_community_post:
        className = "GetAllCommunityResponse";
        break;
      case API.get_community_post_details:
        className = "CommentListResponse";
        break;
      case API.get_all_saved_community_post:
        className = "SavedPostListResponse";
        break;
      case API.mycourse:
        className = "MycourseResponse";
        break;
      case API.membership:
        className = "GetmembershipPlanResponse";
        break;
       case API.checkSubscriptionIndividualFlowWiseInfo:
        className = "CheckSubscriptionIndividualFlowWiseInfoResponse";
        break;
          case API.fetchCustomerloginDeviceInfo:
        className = "GetLoggedInDevicesResponse";
        break;
         case API.customerProcessSubscription:
        className = "PayNowResponse";
        break;
         case API.getUpcomingCourses:
        className = "UpcomingCoursesResponse";
        break;
           case API.faq:
        className = "FAQResponse";
        break;
         case API.getCourseReviews:
        className = "GetCourseReviewResponse";
        break;
         case API.searchCourseMaster:
        className = "SeachListResponse";
        break;
        
      default:
        className = 'CommonResponse';
    }
    return className;
  }

  dynamic parseResponse(String className, var json) {
    dynamic responseObj;

    if (className == 'SignUpResponse') {
      responseObj = SignUpResponse.fromJson(json);
    }
    if (className == 'CategoryListResponse') {
      responseObj = CategoryListResponse.fromJson(json);
    }
    if (className == 'LoginResponse') {
      responseObj = LoginResponse.fromJson(json);
    }
    if (className == 'CommonResponse') {
      responseObj = CommonResponse.fromJson(json);
    }
    if (className == 'ForgetpasswordResponse') {
      responseObj = ForgetpasswordResponse.fromJson(json);
    }
    if (className == 'UpdatepasswordResponse') {
      responseObj = UpdatepasswordResponse.fromJson(json);
    }
    if (className == 'LandingScreenResponse') {
      responseObj = LandingScreenResponse.fromJson(json);
    }
    if (className == 'GetAllPlanResponse') {
      responseObj = GetAllPlanResponse.fromJson(json);
    }
    if (className == 'GetServicesResponse') {
      responseObj = GetServicesResponse.fromJson(json);
    }
    if (className == 'TestimonialResponse') {
      responseObj = TestimonialResponse.fromJson(json);
    }
    if (className == 'CustomerCategoryListResponse') {
      responseObj = CustomerCategoryListResponse.fromJson(json);
    }
    if (className == 'CustomerIdCategoryWiseResponse') {
      responseObj = CustomerIdCategoryWiseResponse.fromJson(json);
    }
    if (className == 'CategoryWiseResponse') {
      responseObj = CategoryWiseResponse.fromJson(json);
    }
    if (className == 'MasterListResponse') {
      responseObj = MasterListResponse.fromJson(json);
    }
    if (className == 'TrendingMasterResponse') {
      responseObj = TrendingMasterResponse.fromJson(json);
    }
    if (className == 'TrendingClassResponse') {
      responseObj = TrendingClassResponse.fromJson(json);
    }
    if (className == 'MasterDetailClassResponse') {
      responseObj = MasterDetailClassResponse.fromJson(json);
    }
    if (className == 'CustomerInfoResponse') {
      responseObj = CustomerInfoResponse.fromJson(json);
    }
    if (className == 'FetchCustomerInfoResponse') {
      responseObj = FetchCustomerInfoResponse.fromJson(json);
    }
    if (className == 'BlogResponse') {
      responseObj = BlogResponse.fromJson(json);
    }
    if (className == 'BlogDetailResponse') {
      responseObj = BlogDetailResponse.fromJson(json);
    }
    if (className == 'AllCoursesResponse') {
      responseObj = AllCoursesResponse.fromJson(json);
    }
    if (className == 'ParticularCoursesResponse') {
      responseObj = ParticularCoursesResponse.fromJson(json);
    }
    if (className == 'OtherCoursesResponse') {
      responseObj = OtherCoursesResponse.fromJson(json);
    }
    if (className == 'JoinFestivalResponse') {
      responseObj = JoinFestivalResponse.fromJson(json);
    }
    if (className == 'SavedCourseListResponse') {
      responseObj = SavedCourseListResponse.fromJson(json);
    }
    if (className == 'SavedCourseResponse') {
      responseObj = SavedCoursesResponse.fromJson(json);
    }
    if (className == 'GetAllCommunityResponse') {
      responseObj = GetAllCommunityResponse.fromJson(json);
    }
    if (className == 'CommentListResponse') {
      responseObj = CommentListResponse.fromJson(json);
    }
    if (className == 'SavedPostListResponse') {
      responseObj = SavedPostListResponse.fromJson(json);
    }
    if (className == 'MycourseResponse') {
      responseObj = MycourseResponse.fromJson(json);
    }
    if (className == 'GetmembershipPlanResponse') {
      responseObj = GetmembershipPlanResponse.fromJson(json);
    }
     if (className == 'CheckSubscriptionIndividualFlowWiseInfoResponse') {
      responseObj = CheckSubscriptionIndividualFlowWiseInfoResponse.fromJson(json);
    }
     if (className == 'GetLoggedInDevicesResponse') {
      responseObj = GetLoggedInDevicesResponse.fromJson(json);
    }
    if (className == 'PayNowResponse') {
      responseObj = PayNowResponse.fromJson(json);
    }
     if (className == 'UpcomingCoursesResponse') {
      responseObj = UpcomingCoursesResponse.fromJson(json);
    }
       if (className == 'FAQResponse') {
      responseObj = FaqResponse.fromJson(json);
    }
     if (className == 'GetCourseReviewResponse') {
      responseObj = GetCourseReviewResponse.fromJson(json);
    }
     if (className == 'SeachListResponse') {
      responseObj = SeachListResponse.fromJson(json);
    }
    

    return responseObj;
  }

  Future<void> apiRequest(BuildContext context, API api,
      successCallback onSuccess, failureCallback onFailure,
      {dynamic parameter,
      dynamic params,
      dynamic path,
      dynamic jsonval}) async {
    var jsonResponse;
    http.Response? response;
    Map<String, String> headers = {};
    String? token = await SPManager().getAuthToken();
    print("token: ${token}");
    print("token: coming");
    // var body = (parameter != null ? json.encode(parameter) : jsonval);
    // String body = json.encode(jsonval);
    var body = jsonval is String ? jsonval : json.encode(jsonval);
    print("body");
    print("bodu" + body);
    url = await this.apiEndPoint(api);
    if (path != null) {
      url = url + path;
      print(url);
    }

    if (token != null && token.isNotEmpty) {
      headers = {
        "Accept": 'application/json',
        "Content-Type": "application/json",
        "x-api-key": "IjMgJzUSIikuLi1yYAFiMTMuKyQiNWQfZ2s0MiQzeHl2YGAyN",
        "Authorization": "Bearer ${token}"
      };
      print("header is $headers");
    } else {
      headers = {
        "Accept": 'application/json',
        "x-api-key": "IjMgJzUSIikuLi1yYAFiMTMuKyQiNWQfZ2s0MiQzeHl2YGAyN",
        "Content-Type": "application/json",
      };
      // }
    }
    print('URL is $url');

    print("body is $body");

    print("header is $headers");

    try {
      if (this.apiHTTPMethod(api) == HTTPMethod.POST) {
        response =
            await http.post(Uri.parse(url), body: body, headers: headers);
        // .timeout(timeout!);
        print(response.body);
      } else if (this.apiHTTPMethod(api) == HTTPMethod.GET) {
        //   print(url);
        response =
            await http.get(Uri.parse(url), headers: headers).timeout(timeout!);
        // log('response of get');
        //print(response.body);
      } else if (this.apiHTTPMethod(api) == HTTPMethod.PUT) {
        print('body is -' + body);
        response = await http
            .put(
              Uri.parse(url),
              body: body,
              headers: headers,
            )
            .timeout(timeout!);
      } else if (this.apiHTTPMethod(api) == HTTPMethod.DELETE) {
        response = await http
            .delete(Uri.parse(url), headers: headers)
            .timeout(timeout!);
      }

      //TODO : Handle 201 status code as well
        print('API is ${api}');
      print('Resp is ${response!.statusCode}');

      if (response.statusCode == 200) {
        //logout appi response is not json

        jsonResponse = json.decode(response.body);

        if (jsonResponse["status"] == true ||
            jsonResponse["status"] == "success") {
          onSuccess(
              this.parseResponse(this.classNameForAPI(api), jsonResponse));
        } else {
          print("status");
          String message = jsonResponse['message'] ?? 'Unknown Error';
          ShowDialogs.showToast(message);

          if (jsonResponse['errors'] != null) {
            // Assuming 'errors' contains dynamic fields, you can handle them like this:
            Map<String, dynamic> errors = jsonResponse['errors'];

            dynamic dynamicResponse = {
              'message': message,
              'errors': errors,
            };

            // Call onSuccess and return the dynamic response
            onSuccess(dynamicResponse);
          }
        }
      } else if (response.statusCode == 401) {
        ShowDialogs().unAthorizedTokenErrorDialog(context,
            message: "Session expired. Please login again.");
      } else {
        var appError = this.parseError(response);

        onFailure(appError);
      }
    } catch (error) {
      // executed for errors of all types other than Exception
      var appError = FetchDataError(error.toString());
      // FLog.error(
      //     text:
      //         'Time : ${Utility().calculateTime(startTime)} Caller : ${programInfo.callerFunctionName} Error : ${appError.toString()}');
      onFailure(appError);
    }
  }
//   Future<void> apiRequest(BuildContext context, API api,
//       successCallback onSuccess, failureCallback onFailure,
//       {dynamic parameter,
//       dynamic params,
//       dynamic path,
//       dynamic jsonval}) async {
//     var jsonResponse;
//     http.Response? response;
//     Map<String, String> headers = {};
//     String? token = await SPManager().getAuthToken();
//     print("token: ${token}");

//     var body = (parameter != null ? json.encode(parameter) : jsonval);
//     // print("bodu" + body);
//     url = await this.apiEndPoint(api);
//     if (path != null) {
//       url = url + path;
//       print(url);
//     }
//     if (token != "") {
//       headers = {
//         "Accept": 'application/json',
//         "x-api-key": "IjMgJzUSIikuLi1yYAFiMTMuKyQiNWQfZ2s0MiQzeHl2YGAyN",
//         //  "authToken": "1480B32EFFAD474D8F92056B9B242886-61",
//         "Authorization": "Bearer ${token}"
//       };
//       print("header is $headers");
//     } else {
// //       if(api==API.categoryIdsWiseCourses)
// //       {
// //  headers = {

// //       };
// //       }else{
//       headers = {
//         "Accept": 'application/json',
//         "x-api-key": "IjMgJzUSIikuLi1yYAFiMTMuKyQiNWQfZ2s0MiQzeHl2YGAyN"
//         // "authToken":
//         //     "${GlobalLists.loginResponseList.token}  ${"-"} ${GlobalLists.loginResponseList.employeemodel.employeeId}",
//       };
//       // }
//     }
//     print('URL is $url');

//     print("body is $body");

//     print("header is $headers");

//     try {
//       if (this.apiHTTPMethod(api) == HTTPMethod.POST) {
//         response = await http
//             .post(Uri.parse(url), body: body, headers: headers)
//             .timeout(timeout!);
//         print(response.body);
//         print('response of post');
//       } else if (this.apiHTTPMethod(api) == HTTPMethod.GET) {
//         //   print(url);
//         response =
//             await http.get(Uri.parse(url), headers: headers).timeout(timeout!);
//         print('response of get');
//         //print(response.body);
//       } else if (this.apiHTTPMethod(api) == HTTPMethod.PUT) {
//         print('body is -' + body);
//         response = await http
//             .put(
//               Uri.parse(url),
//               body: body,
//               headers: headers,
//             )
//             .timeout(timeout!);
//       } else if (this.apiHTTPMethod(api) == HTTPMethod.DELETE) {
//         response = await http
//             .delete(Uri.parse(url), headers: headers)
//             .timeout(timeout!);
//       }

//       //TODO : Handle 201 status code as well
//       print('Resp is ${response!.statusCode}');
//       if (response.statusCode == 200) {
//         //logout appi response is not json

//         jsonResponse = json.decode(response.body);
//         print('BODY is--> $jsonResponse');
//         print(this.classNameForAPI(api));
//         if (jsonResponse['status'] == true ||
//             jsonResponse['status'] == "success") {
//           onSuccess(
//               this.parseResponse(this.classNameForAPI(api), jsonResponse));
//         } else {
//           print("status");
//           String message = jsonResponse['message'] ?? 'Unknown Error';
//           ShowDialogs.showToast(message);

//           if (jsonResponse['errors'] != null) {
//             // Assuming 'errors' contains dynamic fields, you can handle them like this:
//             Map<String, dynamic> errors = jsonResponse['errors'];

//             // Here, you can decide to pass the entire response or handle specific errors
//             // For instance, you can pass errors separately or wrap them in a custom object
//             dynamic dynamicResponse = {
//               'message': message,
//               'errors': errors,
//             };

//             // Call onSuccess and return the dynamic response
//             onSuccess(dynamicResponse);
//           }
//         }
//         // onSuccess(this.parseResponse(this.classNameForAPI(api), jsonResponse));
//       } else if (response.statusCode == 401) {
//         // ShowDialogs().unAthorizedTokenErrorDialog(context,
//         //     message: "Session expired. Please login again.");
//       } else {
//         var appError = this.parseError(response);
//         // FLog.error(
//         //     text:
//         //         'Caller : ${programInfo.callerFunctionName} Error : ${appError.toString()}');

//         onFailure(appError);
//       }
//     } catch (error) {
//       print('Exception ${error.toString()}');

//       // executed for errors of all types other than Exception
//       var appError = FetchDataError(error.toString());
//       // FLog.error(
//       //     text:
//       //         'Time : ${Utility().calculateTime(startTime)} Caller : ${programInfo.callerFunctionName} Error : ${appError.toString()}');
//       onFailure(appError);
//     }
//   }

  dynamic parseUploadError(String response, int statusCode) {
    var jsonResponse;
    var message;
    if (response != null && response.length > 0) {
      jsonResponse = json.decode(response);
      if (jsonResponse != null && jsonResponse["status_Message"] != null) {
        message = jsonResponse["status_Message"];
      } else {
        message = response;
      }
    }

    switch (statusCode) {
      case 400:
        return BadRequestError(message);
      case 401:
      case 403:
        return UnauthorisedError(message);
      case 500:
        return ShowDialogs.showToast("server Error");
      default:
        return FetchDataError(
            'Error occured while Communication with Server with StatusCode : ${statusCode}');
    }
  }

  dynamic parseError(http.Response response) {
    var jsonResponse;
    var message;

    if (response.body != null && response.body.toString().length > 0) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null && jsonResponse["desc"] != null) {
        message = jsonResponse["desc"];
      } else {
        message = response.body.toString();
      }
    }

    switch (response.statusCode) {
      case 400:
        return BadRequestError(message);
      case 200:
        return MessageError(message);
      case 401:
      case 403:
        return UnauthorisedError(message);
      case 500:
      default:
        return FetchDataError(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
