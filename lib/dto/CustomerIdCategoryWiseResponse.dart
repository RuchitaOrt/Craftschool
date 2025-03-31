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
    status: json["status"] ?? false,
    message: json["message"] ?? "",
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
  dynamic catId;
  String categoryName;
  List<Course> courses;

  Datum({
    required this.catId,
    required this.categoryName,
    required this.courses,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    catId: json["cat_id"] ?? 0,
    categoryName: json["category_name"] ?? "",
    courses: json["courses"] == null 
        ? [] 
        : List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "category_name": categoryName,
    "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
  };
}

class Course {
  String courseId;
  String name;
  String shortDescription;
  String instructor;
  String slug;
  String? tagName;
  String courseBannerDesktop;
  String courseBannerMobile;
  String masterProfilePhoto;
  String masterName;
  int categoryId;
  String categoryName;
   bool savedFlag;


  Course({
    required this.courseId,
    required this.name,
    required this.shortDescription,
    required this.instructor,
    required this.slug,
    this.tagName,
    required this.courseBannerDesktop,
    required this.courseBannerMobile,
    required this.masterProfilePhoto,
    required this.masterName,
    required this.categoryId,
    required this.categoryName,
    required this.savedFlag,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    courseId: json["course_id"] ?? "",
    name: json["name"] ?? "",
    shortDescription: json["short_description"] ?? "",
    instructor: json["instructor"] ?? "",
    slug: json["slug"] ?? "",
    tagName: json["tag_name"],
    courseBannerDesktop: json["course_banner_desktop"] ?? "",
    courseBannerMobile: json["course_banner_mobile"] ?? "",
    masterProfilePhoto: json["master_profile_photo"] ?? "",
    masterName: json["master_name"] ?? "",
    categoryId: json["category_id"] ?? 0,
    categoryName: json["category_name"] ?? "",
    savedFlag: json["saved_flag"] ?? false,
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
    "category_id": categoryId,
    "category_name": categoryName,
    "saved_flag": savedFlag,
  };
}

// import 'dart:convert';

// CustomerIdCategoryWiseResponse customerIdCategoryWiseResponseFromJson(String str) => CustomerIdCategoryWiseResponse.fromJson(json.decode(str));

// String customerIdCategoryWiseResponseToJson(CustomerIdCategoryWiseResponse data) => json.encode(data.toJson());

// class CustomerIdCategoryWiseResponse {
//   bool status;
//   String message;
//   List<Datum> data;

//   CustomerIdCategoryWiseResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory CustomerIdCategoryWiseResponse.fromJson(Map<String, dynamic> json) => CustomerIdCategoryWiseResponse(
//     status: json["status"] ?? false,
//     message: json["message"] ?? '',
//     data: json["data"] == null
//         ? []
//         : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );

//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }

// class Datum {
//   int catId;
//   String categoryName;
//   List<Course> courses;

//   Datum({
//     required this.catId,
//     required this.categoryName,
//     required this.courses,
//   });

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     catId: json["cat_id"] ?? 0,
//     categoryName: json["category_name"] ?? '',
//     courses: json["courses"] == null
//         ? []
//         : List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
//   );

//   Map<String, dynamic> toJson() => {
//     "cat_id": catId,
//     "category_name": categoryName,
//     "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
//   };
// }

// class Course {
//   String courseId;
//   String name;
//   String shortDescription;
//   String instructor;
//   String slug;
//   String tagName;
//   String courseBannerDesktop;
//   String courseBannerMobile;
//   String masterProfilePhoto;
//   String masterName;
//   int categoryId;
//   String categoryName;

//   Course({
//     required this.courseId,
//     required this.name,
//     required this.shortDescription,
//     required this.instructor,
//     required this.slug,
//     required this.tagName,
//     required this.courseBannerDesktop,
//     required this.courseBannerMobile,
//     required this.masterProfilePhoto,
//     required this.masterName,
//     required this.categoryId,
//     required this.categoryName,
//   });

//   factory Course.fromJson(Map<String, dynamic> json) => Course(
//     courseId: json["course_id"] ?? '',
//     name: json["name"] ?? '',
//     shortDescription: json["short_description"] ?? '',
//     instructor: json["instructor"] ?? '',
//     slug: json["slug"] ?? '',
//     tagName: json["tag_name"] ?? '',
//     courseBannerDesktop: json["course_banner_desktop"] ?? '',
//     courseBannerMobile: json["course_banner_mobile"] ?? '',
//     masterProfilePhoto: json["master_profile_photo"] ?? '',
//     masterName: json["master_name"] ?? '',
//     categoryId: json["category_id"] ?? 0,
//     categoryName: json["category_name"] ?? '',
//   );

//   Map<String, dynamic> toJson() => {
//     "course_id": courseId,
//     "name": name,
//     "short_description": shortDescription,
//     "instructor": instructor,
//     "slug": slug,
//     "tag_name": tagName,
//     "course_banner_desktop": courseBannerDesktop,
//     "course_banner_mobile": courseBannerMobile,
//     "master_profile_photo": masterProfilePhoto,
//     "master_name": masterName,
//     "category_id": categoryId,
//     "category_name": categoryName,
//   };
// }
