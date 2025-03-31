import 'dart:convert';

FetchCustomerInfoResponse fetchCustomerInfoResponseFromJson(String str) => FetchCustomerInfoResponse.fromJson(json.decode(str));

String fetchCustomerInfoResponseToJson(FetchCustomerInfoResponse data) => json.encode(data.toJson());

class FetchCustomerInfoResponse {
  bool status;
  String message;
  List<Datum> data;

  FetchCustomerInfoResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchCustomerInfoResponse.fromJson(Map<String, dynamic> json) => FetchCustomerInfoResponse(
    status: json["status"] ?? false,
    message: json["message"] ?? "",
    data: json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String firstName;
  String lastName;
  String email;
  String phoneNo;
  String? userProfilePic;

  Datum({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    this.userProfilePic,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? 0,
    firstName: json["first_name"] ?? "",
    lastName: json["last_name"] ?? "",
    email: json["email"] ?? "",
    phoneNo: json["phone_no"] ?? "",
    userProfilePic: json["user_profile_pic"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone_no": phoneNo,
    "user_profile_pic": userProfilePic ?? "",
  };
}
