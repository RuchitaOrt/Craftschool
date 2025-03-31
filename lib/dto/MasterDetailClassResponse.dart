import 'dart:convert';

MasterDetailClassResponse masterDetailClassResponseFromJson(String str) => MasterDetailClassResponse.fromJson(json.decode(str));

String masterDetailClassResponseToJson(MasterDetailClassResponse data) => json.encode(data.toJson());

class MasterDetailClassResponse {
  bool status;
  String message;
  List<MasterDatum> masterData;
  List<MasterCourse> masterCourses;

  MasterDetailClassResponse({
    required this.status,
    required this.message,
    required this.masterData,
    required this.masterCourses,
  });

  factory MasterDetailClassResponse.fromJson(Map<String, dynamic> json) => MasterDetailClassResponse(
    status: json["status"] ?? false,
    message: json["message"] ?? "",
    masterData: json["master_data"] != null ? List<MasterDatum>.from(json["master_data"].map((x) => MasterDatum.fromJson(x))) : [],
    masterCourses: json["master_courses"] != null ? List<MasterCourse>.from(json["master_courses"].map((x) => MasterCourse.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "master_data": List<dynamic>.from(masterData.map((x) => x.toJson())),
    "master_courses": List<dynamic>.from(masterCourses.map((x) => x.toJson())),
  };
}

class MasterCourse {
  String name;
  String shortDescription;
  String instructor;
  String slug;
  String courseBannerDesktop;
  String courseBannerMobile;
  String masterProfilePhoto;
  String masterName;
  String catname;
   String? courseId;
 
  bool? savedFlag;

  MasterCourse({
    required this.name,
    required this.shortDescription,
    required this.instructor,
    required this.slug,
    required this.courseBannerDesktop,
    required this.courseBannerMobile,
    required this.masterProfilePhoto,
    required this.masterName,
    required this.catname,
    required this.courseId,
    required this.savedFlag,
  });

  factory MasterCourse.fromJson(Map<String, dynamic> json) => MasterCourse(
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
      savedFlag: json["saved_flag"] ?? false,
  );

  Map<String, dynamic> toJson() => {
      "course_id": courseId ?? "",
    "name": name,
    "short_description": shortDescription,
    "instructor": instructor,
    "slug": slug,
    "course_banner_desktop": courseBannerDesktop,
    "course_banner_mobile": courseBannerMobile,
    "master_profile_photo": masterProfilePhoto,
    "master_name": masterName,
    "catname": catname,
    "saved_flag": savedFlag ?? false,
  };
}

class MasterDatum {
  String masterImage;
  String name;
  String profession;
  String bio;
  List<dynamic> awards;
  List<dynamic> tags;
  String slug;

  MasterDatum({
    required this.masterImage,
    required this.name,
    required this.profession,
    required this.bio,
    required this.awards,
    required this.tags,
    required this.slug,
  });

  factory MasterDatum.fromJson(Map<String, dynamic> json) => MasterDatum(
    masterImage: json["master_image"] ?? "",
    name: json["name"] ?? "",
    profession: json["profession"] ?? "",
    bio: json["bio"] ?? "",
    awards: json["awards"] != null ? List<dynamic>.from(json["awards"].map((x) => x)) : [],
    tags: json["tags"] != null ? List<dynamic>.from(json["tags"].map((x) => x)) : [],
    slug: json["slug"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "master_image": masterImage,
    "name": name,
    "profession": profession,
    "bio": bio,
    "awards": List<dynamic>.from(awards.map((x) => x)),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "slug": slug,
  };
}
