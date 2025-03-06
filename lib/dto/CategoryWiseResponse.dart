// To parse this JSON data, do
//
//     final categoryWiseResponse = categoryWiseResponseFromJson(jsonString);

import 'dart:convert';

CategoryWiseResponse categoryWiseResponseFromJson(String str) => CategoryWiseResponse.fromJson(json.decode(str));

String categoryWiseResponseToJson(CategoryWiseResponse data) => json.encode(data.toJson());

class CategoryWiseResponse {
    bool status;
    String message;
    List<Datum> data;

    CategoryWiseResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CategoryWiseResponse.fromJson(Map<String, dynamic> json) => CategoryWiseResponse(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String name;
    String shortDescription;
    String instructor;
    String slug;
    String courseBannerDesktop;
    String courseBannerMobile;
    String masterProfilePhoto;
    String masterName;
    String catname;

    Datum({
        required this.name,
        required this.shortDescription,
        required this.instructor,
        required this.slug,
        required this.courseBannerDesktop,
        required this.courseBannerMobile,
        required this.masterProfilePhoto,
        required this.masterName,
        required this.catname,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        shortDescription: json["short_description"],
        instructor: json["instructor"],
        slug: json["slug"],
        courseBannerDesktop: json["course_banner_desktop"],
        courseBannerMobile: json["course_banner_mobile"],
        masterProfilePhoto: json["master_profile_photo"],
        masterName: json["master_name"],
        catname: json["catname"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "short_description": shortDescription,
        "instructor": instructor,
        "slug": slug,
        "course_banner_desktop": courseBannerDesktop,
        "course_banner_mobile": courseBannerMobile,
        "master_profile_photo": masterProfilePhoto,
        "master_name": masterName,
        "catname": catname,
    };
}
