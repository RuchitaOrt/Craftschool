// To parse this JSON data, do
//
//     final updatepasswordResponse = updatepasswordResponseFromJson(jsonString);

import 'dart:convert';

UpdatepasswordResponse updatepasswordResponseFromJson(String str) => UpdatepasswordResponse.fromJson(json.decode(str));

String updatepasswordResponseToJson(UpdatepasswordResponse data) => json.encode(data.toJson());

class UpdatepasswordResponse {
    String status;
    String message;

    UpdatepasswordResponse({
        required this.status,
        required this.message,
    });

    factory UpdatepasswordResponse.fromJson(Map<String, dynamic> json) => UpdatepasswordResponse(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
