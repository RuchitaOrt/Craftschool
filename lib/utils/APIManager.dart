import 'dart:convert';
import 'dart:io';

import 'package:craft_school/dto/CategoryListResponse.dart';
import 'package:craft_school/dto/CategoryWiseResponse.dart';
import 'package:craft_school/dto/CustomerCategoryListResponse.dart';
import 'package:craft_school/dto/CustomerIdCategoryWiseResponse.dart';
import 'package:craft_school/dto/ForgetpasswordResponse.dart';
import 'package:craft_school/dto/GetAllPlanResponse.dart';
import 'package:craft_school/dto/GetServicesResponse.dart';
import 'package:craft_school/dto/LandingScreenResponse.dart';
import 'package:craft_school/dto/LoginResponse.dart';
import 'package:craft_school/dto/LogoutResponse.dart';
import 'package:craft_school/dto/SignUpResponse.dart';
import 'package:craft_school/dto/TestimonialResponse.dart';
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
  Landingsliders,
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
        className = "LogoutResponse";
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
    if (className == 'LogoutResponse') {
      responseObj = LogoutResponse.fromJson(json);
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

    var body = (parameter != null ? json.encode(parameter) : jsonval);
    // print("bodu" + body);
    url = await this.apiEndPoint(api);
    if (path != null) {
      url = url + path;
      print(url);
    }
    if (token != "") {
      headers = {
        "Accept": 'application/json',
         "x-api-key": "IjMgJzUSIikuLi1yYAFiMTMuKyQiNWQfZ2s0MiQzeHl2YGAyN",
        //  "authToken": "1480B32EFFAD474D8F92056B9B242886-61",
         "Authorization": "Bearer ${token}"
      };
      print("header is $headers");
    } else {
//       if(api==API.categoryIdsWiseCourses)
//       {
//  headers = {
       
//       };
//       }else{
         headers = {
        "Accept": 'application/json',
         "x-api-key": "IjMgJzUSIikuLi1yYAFiMTMuKyQiNWQfZ2s0MiQzeHl2YGAyN"
        // "authToken":
        //     "${GlobalLists.loginResponseList.token}  ${"-"} ${GlobalLists.loginResponseList.employeemodel.employeeId}",
      };
      // }
     
    }
    print('URL is $url');

    print("body is $body");

    print("header is $headers");

    try {
      if (this.apiHTTPMethod(api) == HTTPMethod.POST) {
        response = await http
            .post(Uri.parse(url), body: body, headers: headers)
            .timeout(timeout!);
        print(response.body);
        print('response of post');
      } else if (this.apiHTTPMethod(api) == HTTPMethod.GET) {
        //   print(url);
        response =
            await http.get(Uri.parse(url), headers: headers).timeout(timeout!);
        print('response of get');
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
      print('Resp is ${response!.statusCode}');
      if (response.statusCode == 200) {
        //logout appi response is not json

        jsonResponse = json.decode(response.body);
        print('BODY is--> $jsonResponse');
        print(this.classNameForAPI(api));
        if (jsonResponse['status'] == true || jsonResponse['status'] == "success") {
          onSuccess(
              this.parseResponse(this.classNameForAPI(api), jsonResponse));
        } else {
          print("status");
          String message = jsonResponse['message'] ?? 'Unknown Error';
          ShowDialogs.showToast(message);

          if (jsonResponse['errors'] != null) {
            // Assuming 'errors' contains dynamic fields, you can handle them like this:
            Map<String, dynamic> errors = jsonResponse['errors'];

            // Here, you can decide to pass the entire response or handle specific errors
            // For instance, you can pass errors separately or wrap them in a custom object
            dynamic dynamicResponse = {
              'message': message,
              'errors': errors,
            };

            // Call onSuccess and return the dynamic response
            onSuccess(dynamicResponse);
          }
        }
        // onSuccess(this.parseResponse(this.classNameForAPI(api), jsonResponse));
      } else if (response.statusCode == 401) {
        // ShowDialogs().unAthorizedTokenErrorDialog(context,
        //     message: "Session expired. Please login again.");
      } else {
        var appError = this.parseError(response);
        // FLog.error(
        //     text:
        //         'Caller : ${programInfo.callerFunctionName} Error : ${appError.toString()}');

        onFailure(appError);
      }
    } catch (error) {
      print('Exception ${error.toString()}');

      // executed for errors of all types other than Exception
      var appError = FetchDataError(error.toString());
      // FLog.error(
      //     text:
      //         'Time : ${Utility().calculateTime(startTime)} Caller : ${programInfo.callerFunctionName} Error : ${appError.toString()}');
      onFailure(appError);
    }
  }

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
