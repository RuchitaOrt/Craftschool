import 'dart:convert';

MycourseResponse mycourseResponseFromJson(String str) => MycourseResponse.fromJson(json.decode(str));

String mycourseResponseToJson(MycourseResponse data) => json.encode(data.toJson());

class MycourseResponse {
  bool status;
  String message;
  List<Datum> data;

  MycourseResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MycourseResponse.fromJson(Map<String, dynamic> json) => MycourseResponse(
    status: json["status"] ?? false,
    message: json["message"] ?? '',
    data: json["data"] == null
        ? []
        : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String customerId;
  String courseName;
  String masterName;
  String instructorName;
  String courseId;
  String courseSlug;
  dynamic category;
  dynamic masterId;
  dynamic totalWatchTimeSeconds;
  dynamic courseDurationSeconds;
  String courseBannerDesktop;
  String courseBannerMobile;
  String masterProfilePhoto;
  dynamic completionPercentage;
  String completionStatus;

  bool savedFlag;
  Datum({
    required this.customerId,
    required this.courseName,
    required this.masterName,
    required this.instructorName,
    required this.courseId,
    required this.courseSlug,
    required this.category,
    required this.masterId,
    required this.totalWatchTimeSeconds,
    required this.courseDurationSeconds,
    required this.courseBannerDesktop,
    required this.courseBannerMobile,
    required this.masterProfilePhoto,
    required this.completionPercentage,
    required this.completionStatus,
           required this.savedFlag,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    customerId: json["customer_id"] ?? '',
    courseName: json["course_name"] ?? '',
    masterName: json["master_name"] ?? '',
    instructorName: json["instructor_name"] ?? '',
    courseId: json["course_id"] ?? '',
    courseSlug: json["course_slug"] ?? '',
    category: json["category"] ?? 0,
    masterId: json["master_id"] ?? 0,
    totalWatchTimeSeconds: json["total_watch_time_seconds"] ?? 0,
    courseDurationSeconds: json["course_duration_seconds"] ?? 0,
    courseBannerDesktop: json["course_banner_desktop"] ?? '',
    courseBannerMobile: json["course_banner_mobile"] ?? '',
    masterProfilePhoto: json["master_profile_photo"] ?? '',
    completionPercentage: json["completion_percentage"] ?? 0,
    completionStatus: json["completion_status"] ?? '',
   savedFlag: json["saved_flag"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId,
    "course_name": courseName,
    "master_name": masterName,
    "instructor_name": instructorName,
    "course_id": courseId,
    "course_slug": courseSlug,
    "category": category,
    "master_id": masterId,
    "total_watch_time_seconds": totalWatchTimeSeconds,
    "course_duration_seconds": courseDurationSeconds,
    "course_banner_desktop": courseBannerDesktop,
    "course_banner_mobile": courseBannerMobile,
    "master_profile_photo": masterProfilePhoto,
    "completion_percentage": completionPercentage,
    "completion_status": completionStatus,
    "saved_flag": savedFlag,
  };
}
