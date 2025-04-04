import 'dart:convert';

GetCourseReviewResponse getCourseReviewResponseFromJson(String str) =>
    GetCourseReviewResponse.fromJson(json.decode(str));

String getCourseReviewResponseToJson(GetCourseReviewResponse data) =>
    json.encode(data.toJson());

class GetCourseReviewResponse {
  bool status;
  String total;
  String message;
  List<Datum> data;

  GetCourseReviewResponse({
    required this.status,
    required this.total,
    required this.message,
    required this.data,
  });

  factory GetCourseReviewResponse.fromJson(Map<String, dynamic> json) =>
      GetCourseReviewResponse(
        status: json["status"] ?? false,
        total: json["total"] ?? "0",
        message: json["message"] ?? "",
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "total": total,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String comments;
  dynamic rating;
  String usersName;
  String userProfilePic;
  DateTime? createdAt;

  Datum({
    required this.comments,
    required this.rating,
    required this.usersName,
    required this.userProfilePic,
    required this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        comments: json["comments"] ?? "",
        rating: json["rating"] ?? 0,
        usersName: json["users_name"] ?? "",
        userProfilePic: json["user_profile_pic"] ?? "",
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "comments": comments,
        "rating": rating,
        "users_name": usersName,
        "user_profile_pic": userProfilePic,
        "created_at": createdAt?.toIso8601String(),
      };
}
