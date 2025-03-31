import 'dart:convert';

UpcomingCoursesResponse upcomingCoursesResponseFromJson(String str) =>
    UpcomingCoursesResponse.fromJson(json.decode(str));

String upcomingCoursesResponseToJson(UpcomingCoursesResponse data) =>
    json.encode(data.toJson());

class UpcomingCoursesResponse {
  bool status;
  String message;
  List<Datum> data;

  UpcomingCoursesResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpcomingCoursesResponse.fromJson(Map<String, dynamic> json) =>
      UpcomingCoursesResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? '',
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String courseId;
  String name;
  String shortDescription;
  String instructor;
  String slug;
  String tagName;
  String courseBannerDesktop;
  String courseBannerMobile;
  String masterProfilePhoto;
  String masterName;
  String catname;
  String courseStartDate;

  Datum({
    required this.courseId,
    required this.name,
    required this.shortDescription,
    required this.instructor,
    required this.slug,
    required this.tagName,
    required this.courseBannerDesktop,
    required this.courseBannerMobile,
    required this.masterProfilePhoto,
    required this.masterName,
    required this.catname,
    required this.courseStartDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        courseId: json["course_id"] ?? '',
        name: json["name"] ?? '',
        shortDescription: json["short_description"] ?? '',
        instructor: json["instructor"] ?? '',
        slug: json["slug"] ?? '',
        tagName: json["tag_name"] ?? '',
        courseBannerDesktop: json["course_banner_desktop"] ?? '',
        courseBannerMobile: json["course_banner_mobile"] ?? '',
        masterProfilePhoto: json["master_profile_photo"] ?? '',
        masterName: json["master_name"] ?? '',
        catname: json["catname"] ?? '',
        courseStartDate: json["course_start_date"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "course_id": courseId,
        "name": name,
        "short_description": shortDescription,
        "instructor": instructor,
        "slug": slug,
        "tag_name": tagName,
        "course_banner_desktop": courseBannerDesktop,
        "course_banner_mobile": courseBannerMobile,
        "master_profile_photo": masterProfilePhoto,
        "master_name": masterName,
        "catname": catname,
        "course_start_date": courseStartDate,
      };
}
