import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SPManager {
  final String authToken = "authToken";
  final String customerID = "customerID";
  final String customerName = "customerName";
 final String customerEmail = "customerEmail";
  final String customerPhoneNumber = "customerPhoneNumber";
 
  Future<void> clear() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getKeys();
    for (String key in pref.getKeys()) {
      // if (key == "authToken") {
        pref.remove(key);
      // }
    }
    //pref.clear();
  }

  

  //set auth token into shared preferences
  Future<void> setAuthToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.authToken, token);
  }

  //get auth token into shared preferences
  Future<String?> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? val;
    val = (prefs.getString(this.authToken) ?? "");
    return val;
  }



 //set auth token into shared preferences
  Future<void> setCustomerID(String customerID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.customerID, customerID);
  }

  //get auth token into shared preferences
  Future<String?> getcustomerID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? val;
    val = (prefs.getString(this.customerID) ?? "");
    return val;
  }


  //set auth token into shared preferences
  Future<void> setCustomerName(String customerName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.customerName, customerName);
  }

  //get auth token into shared preferences
  Future<String?> getcustomerName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? val;
    val = (prefs.getString(this.customerName) ?? "");
    return val;
  }


  // //set auth token into shared preferences
  // Future<void> setCustomerEmail(String customerEmail) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(this.customerEmail, customerEmail);
  // }

  // //get auth token into shared preferences
  // Future<String?> getcustomerEmail() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? val;
  //   val = (prefs.getString(this.customerEmail) ?? "");
  //   return val;
  // }



  // //set auth token into shared preferences
  // Future<void> setCustomerPhone(String customerPhoneNumber) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(this.customerPhoneNumber, customerPhoneNumber);
  // }

  // //get auth token into shared preferences
  // Future<String?> getcustomerPhone() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? val;
  //   val = (prefs.getString(this.customerPhoneNumber) ?? "");
  //   return val;
  // }
}
