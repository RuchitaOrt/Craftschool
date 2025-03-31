import 'dart:convert';

TrendingClassResponse trendingClassResponseFromJson(String str) =>
    TrendingClassResponse.fromJson(json.decode(str));

String trendingClassResponseToJson(TrendingClassResponse data) =>
    json.encode(data.toJson());

class TrendingClassResponse {
  bool? status;
  String? message;
  List<Datum>? data;

  TrendingClassResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TrendingClassResponse.fromJson(Map<String, dynamic> json) =>
      TrendingClassResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status ?? false,
        "message": message ?? "",
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : [],
      };
}

class Datum {
  String? courseId;
  String? name;
  String? shortDescription;
  String? instructor;
  String? slug;
  String? courseBannerDesktop;
  String? courseBannerMobile;
  String? masterProfilePhoto;
  String? masterName;
  String? catname;
  String? tagName;
  bool? savedFlag;

  Datum({
    this.courseId,
    this.name,
    this.shortDescription,
    this.instructor,
    this.slug,
    this.courseBannerDesktop,
    this.courseBannerMobile,
    this.masterProfilePhoto,
    this.masterName,
    this.catname,
    this.tagName,
    this.savedFlag,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        courseId: json["course_id"] ?? "",
        name: json["name"] ?? "",
        shortDescription: json["short_description"] ?? "",
        instructor: json["instructor"] ?? "",
        slug: json["slug"] ?? "",
        courseBannerDesktop: json["course_banner_desktop"] ?? "",
        courseBannerMobile: json["course_banner_mobile"] ?? "",
        masterProfilePhoto: json["master_profile_photo"] ?? "",
        masterName: json["master_name"] ?? "",
        catname: json["catname"] ?? "",
        tagName: json["tag_name"],
        savedFlag: json["saved_flag"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "course_id": courseId ?? "",
        "name": name ?? "",
        "short_description": shortDescription ?? "",
        "instructor": instructor ?? "",
        "slug": slug ?? "",
        "course_banner_desktop": courseBannerDesktop ?? "",
        "course_banner_mobile": courseBannerMobile ?? "",
        "master_profile_photo": masterProfilePhoto ?? "",
        "master_name": masterName ?? "",
        "catname": catname ?? "",
        "tag_name": tagName,
        "saved_flag": savedFlag ?? false,
      };
}

// import 'dart:convert';

// TrendingClassResponse trendingClassResponseFromJson(String str) => TrendingClassResponse.fromJson(json.decode(str));

// String trendingClassResponseToJson(TrendingClassResponse data) => json.encode(data.toJson());

// class TrendingClassResponse {
//   bool status;
//   String message;
//   List<Datum> data;

//   TrendingClassResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory TrendingClassResponse.fromJson(Map<String, dynamic> json) => TrendingClassResponse(
//     status: json["status"] ?? false,
//     message: json["message"] ?? '',
//     data: List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
//   );

//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }

// class Datum {
//   String name;
//   String shortDescription;
//   String instructor;
//   String slug;
//   String courseBannerDesktop;
//   String courseBannerMobile;
//   String masterProfilePhoto;
//   String masterName;
//   String catname;
//   String? tagName;

//   Datum({
//     required this.name,
//     required this.shortDescription,
//     required this.instructor,
//     required this.slug,
//     required this.courseBannerDesktop,
//     required this.courseBannerMobile,
//     required this.masterProfilePhoto,
//     required this.masterName,
//     required this.catname,
//     this.tagName,
//   });

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     name: json["name"] ?? '',
//     shortDescription: json["short_description"] ?? '',
//     instructor: json["instructor"] ?? '',
//     slug: json["slug"] ?? '',
//     courseBannerDesktop: json["course_banner_desktop"] ?? '',
//     courseBannerMobile: json["course_banner_mobile"] ?? '',
//     masterProfilePhoto: json["master_profile_photo"] ?? '',
//     masterName: json["master_name"] ?? '',
//     catname: json["catname"] ?? '',
//     tagName: json["tag_name"],
//   );

//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "short_description": shortDescription,
//     "instructor": instructor,
//     "slug": slug,
//     "course_banner_desktop": courseBannerDesktop,
//     "course_banner_mobile": courseBannerMobile,
//     "master_profile_photo": masterProfilePhoto,
//     "master_name": masterName,
//     "catname": catname,
//     "tag_name": tagName,
//   };
// }
