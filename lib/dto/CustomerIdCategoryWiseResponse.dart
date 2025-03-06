// To parse this JSON data, do
//
//     final customerIdCategoryWiseResponse = customerIdCategoryWiseResponseFromJson(jsonString);

import 'dart:convert';

CustomerIdCategoryWiseResponse customerIdCategoryWiseResponseFromJson(String str) => CustomerIdCategoryWiseResponse.fromJson(json.decode(str));

String customerIdCategoryWiseResponseToJson(CustomerIdCategoryWiseResponse data) => json.encode(data.toJson());

class CustomerIdCategoryWiseResponse {
    bool status;
    String message;
    List<Datum> data;

    CustomerIdCategoryWiseResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CustomerIdCategoryWiseResponse.fromJson(Map<String, dynamic> json) => CustomerIdCategoryWiseResponse(
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
    int catId;
    String categoryName;
    List<Course> courses;

    Datum({
        required this.catId,
        required this.categoryName,
        required this.courses,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        catId: json["cat_id"],
        categoryName: json["category_name"],
        courses: List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "category_name": categoryName,
        "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
    };
}

class Course {
    String name;
    String shortDescription;
    String instructor;
    String slug;
    String courseBannerDesktop;
    String courseBannerMobile;
    String masterProfilePhoto;
    String masterName;
    int categoryId;
    String categoryName;

    Course({
        required this.name,
        required this.shortDescription,
        required this.instructor,
        required this.slug,
        required this.courseBannerDesktop,
        required this.courseBannerMobile,
        required this.masterProfilePhoto,
        required this.masterName,
        required this.categoryId,
        required this.categoryName,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        name: json["name"],
        shortDescription: json["short_description"],
        instructor: json["instructor"],
        slug: json["slug"],
        courseBannerDesktop: json["course_banner_desktop"],
        courseBannerMobile: json["course_banner_mobile"],
        masterProfilePhoto: json["master_profile_photo"],
        masterName: json["master_name"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
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
        "category_id": categoryId,
        "category_name": categoryName,
    };
}
