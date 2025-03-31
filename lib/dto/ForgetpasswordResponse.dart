import 'dart:convert';

ForgetpasswordResponse forgetpasswordResponseFromJson(String str) => ForgetpasswordResponse.fromJson(json.decode(str));

String forgetpasswordResponseToJson(ForgetpasswordResponse data) => json.encode(data.toJson());

class ForgetpasswordResponse {
  bool status;
  String message;
  List<dynamic> data;

  ForgetpasswordResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ForgetpasswordResponse.fromJson(Map<String, dynamic> json) => ForgetpasswordResponse(
    status: json["status"] ?? false,
    message: json["message"] ?? "",
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
