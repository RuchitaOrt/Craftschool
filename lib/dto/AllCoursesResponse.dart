import 'dart:convert';

AllCoursesResponse allCoursesResponseFromJson(String str) => AllCoursesResponse.fromJson(json.decode(str));

String allCoursesResponseToJson(AllCoursesResponse data) => json.encode(data.toJson());

class AllCoursesResponse {
  bool status;
  dynamic total;
  String message;
  List<Datum> data;

  AllCoursesResponse({
    required this.status,
    required this.total,
    required this.message,
    required this.data,
  });

  factory AllCoursesResponse.fromJson(Map<String, dynamic> json) => AllCoursesResponse(
    status: json["status"] ?? false,
    total: json["total"] ?? 0,
    message: json["message"] ?? '',
    data: json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total": total,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String name;
  String courseId;
  String shortDescription;
  String instructor;
  String slug;
  String tagName;
  String courseBannerDesktop;
  String courseBannerMobile;
  String masterProfilePhoto;
  String masterName;
  String catname;
   bool savedFlag;

  Datum({
    required this.name,
    required this.courseId,
    required this.shortDescription,
    required this.instructor,
    required this.slug,
    required this.tagName,
    required this.courseBannerDesktop,
    required this.courseBannerMobile,
    required this.masterProfilePhoto,
    required this.masterName,
    required this.catname,
    required this.savedFlag,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"] ?? '',
    courseId: json["course_id"] ?? '',
    shortDescription: json["short_description"] ?? '',
    instructor: json["instructor"] ?? '',
    slug: json["slug"] ?? '',
    tagName: json["tag_name"] ?? '',
    courseBannerDesktop: json["course_banner_desktop"] ?? '',
    courseBannerMobile: json["course_banner_mobile"] ?? '',
    masterProfilePhoto: json["master_profile_photo"] ?? '',
    masterName: json["master_name"] ?? '',
    catname: json["catname"] ?? '',
    savedFlag: json["saved_flag"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "course_id": courseId,
    "short_description": shortDescription,
    "instructor": instructor,
    "slug": slug,
    "tag_name": tagName,
    "course_banner_desktop": courseBannerDesktop,
    "course_banner_mobile": courseBannerMobile,
    "master_profile_photo": masterProfilePhoto,
    "master_name": masterName,
    "catname": catname,
    "saved_flag": savedFlag,
  };
}
