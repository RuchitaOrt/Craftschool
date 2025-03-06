// To parse this JSON data, do
//
//     final landingScreenResponse = landingScreenResponseFromJson(jsonString);

import 'dart:convert';

LandingScreenResponse landingScreenResponseFromJson(String str) => LandingScreenResponse.fromJson(json.decode(str));

String landingScreenResponseToJson(LandingScreenResponse data) => json.encode(data.toJson());

class LandingScreenResponse {
    bool status;
    String message;
    LandingScreenResponseData data;

    LandingScreenResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory LandingScreenResponse.fromJson(Map<String, dynamic> json) => LandingScreenResponse(
        status: json["status"],
        message: json["message"],
        data: LandingScreenResponseData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class LandingScreenResponseData {
    Banners banners;
    Courses courses;
    Masters masters;
    CarousalImages carousalImages;

    LandingScreenResponseData({
        required this.banners,
        required this.courses,
        required this.masters,
        required this.carousalImages,
    });

    factory LandingScreenResponseData.fromJson(Map<String, dynamic> json) => LandingScreenResponseData(
        banners: Banners.fromJson(json["banners"]),
        courses: Courses.fromJson(json["courses"]),
        masters: Masters.fromJson(json["masters"]),
        carousalImages: CarousalImages.fromJson(json["carousalImages"]),
    );

    Map<String, dynamic> toJson() => {
        "banners": banners.toJson(),
        "courses": courses.toJson(),
        "masters": masters.toJson(),
        "carousalImages": carousalImages.toJson(),
    };
}

class Banners {
    bool status;
    String message;
    BannersData data;

    Banners({
        required this.status,
        required this.message,
        required this.data,
    });

    factory Banners.fromJson(Map<String, dynamic> json) => Banners(
        status: json["status"],
        message: json["message"],
        data: BannersData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class BannersData {
    List<Banner> banner1;
    List<Banner> banner2;
    List<Banner> banner3;

    BannersData({
        required this.banner1,
        required this.banner2,
        required this.banner3,
    });

    factory BannersData.fromJson(Map<String, dynamic> json) => BannersData(
        banner1: List<Banner>.from(json["banner1"].map((x) => Banner.fromJson(x))),
        banner2: List<Banner>.from(json["banner2"].map((x) => Banner.fromJson(x))),
        banner3: List<Banner>.from(json["banner3"].map((x) => Banner.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "banner1": List<dynamic>.from(banner1.map((x) => x.toJson())),
        "banner2": List<dynamic>.from(banner2.map((x) => x.toJson())),
        "banner3": List<dynamic>.from(banner3.map((x) => x.toJson())),
    };
}

class Banner {
    String desktopImage;
    String mobileImage;
    String trailerVideo;
    String tag;
    String courseTitle;
    String courseSlug;
    String courseShortDesc;
    String? masterName;
    List<Topic>? topics;

    Banner({
        required this.desktopImage,
        required this.mobileImage,
        required this.trailerVideo,
        required this.tag,
        required this.courseTitle,
        required this.courseSlug,
        required this.courseShortDesc,
        this.masterName,
        this.topics,
    });

    factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        desktopImage: json["desktop_image"],
        mobileImage: json["mobile_image"],
        trailerVideo: json["trailer_video"],
        tag: json["tag"],
        courseTitle: json["course_title"],
        courseSlug: json["course_slug"],
        courseShortDesc: json["course_short_desc"],
        masterName: json["master_name"],
        topics: json["topics"] == null ? [] : List<Topic>.from(json["topics"]!.map((x) => Topic.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "desktop_image": desktopImage,
        "mobile_image": mobileImage,
        "trailer_video": trailerVideo,
        "tag": tag,
        "course_title": courseTitle,
        "course_slug": courseSlug,
        "course_short_desc": courseShortDesc,
        "master_name": masterName,
        "topics": topics == null ? [] : List<dynamic>.from(topics!.map((x) => x.toJson())),
    };
}

class Topic {
    String title;
    String description;
    String freeVideo;
    String videoDuration;

    Topic({
        required this.title,
        required this.description,
        required this.freeVideo,
        required this.videoDuration,
    });

    factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        title: json["title"],
        description: json["description"],
        freeVideo: json["free_video"],
        videoDuration: json["video_duration"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "free_video": freeVideo,
        "video_duration": videoDuration,
    };
}

class CarousalImages {
    bool status;
    String message;
    List<CarousalImagesDatum> data;

    CarousalImages({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CarousalImages.fromJson(Map<String, dynamic> json) => CarousalImages(
        status: json["status"],
        message: json["message"],
        data: List<CarousalImagesDatum>.from(json["data"].map((x) => CarousalImagesDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class CarousalImagesDatum {
    String imageUrl;

    CarousalImagesDatum({
        required this.imageUrl,
    });

    factory CarousalImagesDatum.fromJson(Map<String, dynamic> json) => CarousalImagesDatum(
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
    };
}

class Courses {
    bool status;
    String message;
    List<CoursesDatum> data;

    Courses({
        required this.status,
        required this.message,
        required this.data,
    });

    factory Courses.fromJson(Map<String, dynamic> json) => Courses(
        status: json["status"],
        message: json["message"],
        data: List<CoursesDatum>.from(json["data"].map((x) => CoursesDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class CoursesDatum {
    String name;
    String shortDescription;
    String instructor;
    String slug;
    String courseBannerDesktop;
    String courseBannerMobile;
    String masterProfilePhoto;
    String masterName;
    String catname;
    String? tagName;

    CoursesDatum({
        required this.name,
        required this.shortDescription,
        required this.instructor,
        required this.slug,
        required this.courseBannerDesktop,
        required this.courseBannerMobile,
        required this.masterProfilePhoto,
        required this.masterName,
        required this.catname,
        required this.tagName,
    });

    factory CoursesDatum.fromJson(Map<String, dynamic> json) => CoursesDatum(
        name: json["name"],
        shortDescription: json["short_description"],
        instructor: json["instructor"],
        slug: json["slug"],
        courseBannerDesktop: json["course_banner_desktop"],
        courseBannerMobile: json["course_banner_mobile"],
        masterProfilePhoto: json["master_profile_photo"],
        masterName: json["master_name"],
        catname: json["catname"],
        tagName: json["tag_name"],
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
        "tag_name": tagName,
    };
}

class Masters {
    bool status;
    String message;
    List<MastersDatum> data;

    Masters({
        required this.status,
        required this.message,
        required this.data,
    });

    factory Masters.fromJson(Map<String, dynamic> json) => Masters(
        status: json["status"],
        message: json["message"],
        data: List<MastersDatum>.from(json["data"].map((x) => MastersDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class MastersDatum {
    String masterImage;
    String name;
    String profession;
    String slug;

    MastersDatum({
        required this.masterImage,
        required this.name,
        required this.profession,
        required this.slug,
    });

    factory MastersDatum.fromJson(Map<String, dynamic> json) => MastersDatum(
        masterImage: json["master_image"],
        name: json["name"],
        profession: json["profession"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "master_image": masterImage,
        "name": name,
        "profession": profession,
        "slug": slug,
    };
}

// // To parse this JSON data, do
// //
// //     final landingScreenResponse = landingScreenResponseFromJson(jsonString);

// import 'dart:convert';

// LandingScreenResponse landingScreenResponseFromJson(String str) => LandingScreenResponse.fromJson(json.decode(str));

// String landingScreenResponseToJson(LandingScreenResponse data) => json.encode(data.toJson());

// class LandingScreenResponse {
//     bool status;
//     String message;
//     Data data;

//     LandingScreenResponse({
//         required this.status,
//         required this.message,
//         required this.data,
//     });

//     factory LandingScreenResponse.fromJson(Map<String, dynamic> json) => LandingScreenResponse(
//         status: json["status"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data.toJson(),
//     };
// }

// class Data {
//     Banners banners;
//     List<Course> courses;
//     List<Master> masters;
//     List<CarousalImage> carousalImages;

//     Data({
//         required this.banners,
//         required this.courses,
//         required this.masters,
//         required this.carousalImages,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         banners: Banners.fromJson(json["banners"]),
//         courses: List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
//         masters: List<Master>.from(json["masters"].map((x) => Master.fromJson(x))),
//         carousalImages: List<CarousalImage>.from(json["carousalImages"].map((x) => CarousalImage.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "banners": banners.toJson(),
//         "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
//         "masters": List<dynamic>.from(masters.map((x) => x.toJson())),
//         "carousalImages": List<dynamic>.from(carousalImages.map((x) => x.toJson())),
//     };
// }

// class Banners {
//     List<Banner> banner1;
//     List<Banner> banner2;
//     List<Banner> banner3;

//     Banners({
//         required this.banner1,
//         required this.banner2,
//         required this.banner3,
//     });

//     factory Banners.fromJson(Map<String, dynamic> json) => Banners(
//         banner1: List<Banner>.from(json["banner1"].map((x) => Banner.fromJson(x))),
//         banner2: List<Banner>.from(json["banner2"].map((x) => Banner.fromJson(x))),
//         banner3: List<Banner>.from(json["banner3"].map((x) => Banner.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "banner1": List<dynamic>.from(banner1.map((x) => x.toJson())),
//         "banner2": List<dynamic>.from(banner2.map((x) => x.toJson())),
//         "banner3": List<dynamic>.from(banner3.map((x) => x.toJson())),
//     };
// }

// class Banner {
//     String desktopImage;
//     String mobileImage;
//     String trailerVideo;
//     String tag;
//     String courseTitle;
//     String courseSlug;
//     String courseShortDesc;
//     String? masterName;
//     List<Topic>? topics;

//     Banner({
//         required this.desktopImage,
//         required this.mobileImage,
//         required this.trailerVideo,
//         required this.tag,
//         required this.courseTitle,
//         required this.courseSlug,
//         required this.courseShortDesc,
//         this.masterName,
//         this.topics,
//     });

//     factory Banner.fromJson(Map<String, dynamic> json) => Banner(
//         desktopImage: json["desktop_image"],
//         mobileImage: json["mobile_image"],
//         trailerVideo: json["trailer_video"],
//         tag: json["tag"],
//         courseTitle: json["course_title"],
//         courseSlug: json["course_slug"],
//         courseShortDesc: json["course_short_desc"],
//         masterName: json["master_name"],
//         topics: json["topics"] == null ? [] : List<Topic>.from(json["topics"]!.map((x) => Topic.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "desktop_image": desktopImage,
//         "mobile_image": mobileImage,
//         "trailer_video": trailerVideo,
//         "tag": tag,
//         "course_title": courseTitle,
//         "course_slug": courseSlug,
//         "course_short_desc": courseShortDesc,
//         "master_name": masterName,
//         "topics": topics == null ? [] : List<dynamic>.from(topics!.map((x) => x.toJson())),
//     };
// }

// class Topic {
//     String title;
//     String description;
//     String freeVideo;
//     String videoDuration;

//     Topic({
//         required this.title,
//         required this.description,
//         required this.freeVideo,
//         required this.videoDuration,
//     });

//     factory Topic.fromJson(Map<String, dynamic> json) => Topic(
//         title: json["title"],
//         description: json["description"],
//         freeVideo: json["free_video"],
//         videoDuration: json["video_duration"],
//     );

//     Map<String, dynamic> toJson() => {
//         "title": title,
//         "description": description,
//         "free_video": freeVideo,
//         "video_duration": videoDuration,
//     };
// }

// class CarousalImage {
//     String imageUrl;

//     CarousalImage({
//         required this.imageUrl,
//     });

//     factory CarousalImage.fromJson(Map<String, dynamic> json) => CarousalImage(
//         imageUrl: json["image_url"],
//     );

//     Map<String, dynamic> toJson() => {
//         "image_url": imageUrl,
//     };
// }

// class Course {
//     String name;
//     String shortDescription;
//     String instructor;
//     String slug;
//     String courseBannerDesktop;
//     String courseBannerMobile;
//     String masterProfilePhoto;
//     String masterName;
//     String catname;
//     String? tagName;

//     Course({
//         required this.name,
//         required this.shortDescription,
//         required this.instructor,
//         required this.slug,
//         required this.courseBannerDesktop,
//         required this.courseBannerMobile,
//         required this.masterProfilePhoto,
//         required this.masterName,
//         required this.catname,
//         required this.tagName,
//     });

//     factory Course.fromJson(Map<String, dynamic> json) => Course(
//         name: json["name"],
//         shortDescription: json["short_description"],
//         instructor: json["instructor"],
//         slug: json["slug"],
//         courseBannerDesktop: json["course_banner_desktop"],
//         courseBannerMobile: json["course_banner_mobile"],
//         masterProfilePhoto: json["master_profile_photo"],
//         masterName: json["master_name"],
//         catname: json["catname"],
//         tagName: json["tag_name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "name": name,
//         "short_description": shortDescription,
//         "instructor": instructor,
//         "slug": slug,
//         "course_banner_desktop": courseBannerDesktop,
//         "course_banner_mobile": courseBannerMobile,
//         "master_profile_photo": masterProfilePhoto,
//         "master_name": masterName,
//         "catname": catname,
//         "tag_name": tagName,
//     };
// }

// class Master {
//     String masterImage;
//     String name;
//     String profession;
//     String slug;

//     Master({
//         required this.masterImage,
//         required this.name,
//         required this.profession,
//         required this.slug,
//     });

//     factory Master.fromJson(Map<String, dynamic> json) => Master(
//         masterImage: json["master_image"],
//         name: json["name"],
//         profession: json["profession"],
//         slug: json["slug"],
//     );

//     Map<String, dynamic> toJson() => {
//         "master_image": masterImage,
//         "name": name,
//         "profession": profession,
//         "slug": slug,
//     };
// }
