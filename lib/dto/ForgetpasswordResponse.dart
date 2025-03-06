// To parse this JSON data, do
//
//     final forgetpasswordResponse = forgetpasswordResponseFromJson(jsonString);

import 'dart:convert';

ForgetpasswordResponse forgetpasswordResponseFromJson(String str) => ForgetpasswordResponse.fromJson(json.decode(str));

String forgetpasswordResponseToJson(ForgetpasswordResponse data) => json.encode(data.toJson());

class ForgetpasswordResponse {
 
    bool status;
    String message;
    Result result;

    ForgetpasswordResponse({
       
        required this.status,
        required this.message,
        required this.result,
    });

    factory ForgetpasswordResponse.fromJson(Map<String, dynamic> json) => ForgetpasswordResponse(
       
        status: json["status"],
        message: json["message"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
       
        "status": status,
        "message": message,
        "result": result.toJson(),
    };
}

class Result {
    Customer customer;
    String email;

    Result({
        required this.customer,
        required this.email,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        customer: Customer.fromJson(json["customer"]),
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "customer": customer.toJson(),
        "email": email,
    };
}

class Customer {
    String iv;
    String encryptedData;

    Customer({
        required this.iv,
        required this.encryptedData,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        iv: json["iv"],
        encryptedData: json["encryptedData"],
    );

    Map<String, dynamic> toJson() => {
        "iv": iv,
        "encryptedData": encryptedData,
    };
}
