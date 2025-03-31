import 'dart:convert';

ParticularCoursesResponse particularCoursesResponseFromJson(String str) => ParticularCoursesResponse.fromJson(json.decode(str));

String particularCoursesResponseToJson(ParticularCoursesResponse data) => json.encode(data.toJson());

class ParticularCoursesResponse {
    bool status;
    String message;
    List<Datum> data;

    ParticularCoursesResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory ParticularCoursesResponse.fromJson(Map<String, dynamic> json) => ParticularCoursesResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? '',
        data: List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    List<CourseDatum> courseData;
    List<CourseModule> courseModules;
    List<MeetYourInstructor> meetYourInstructor;
    List<CourseModule> startCourse;

    Datum({
        required this.courseData,
        required this.courseModules,
        required this.meetYourInstructor,
        required this.startCourse,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        courseData: List<CourseDatum>.from(json["course_data"]?.map((x) => CourseDatum.fromJson(x)) ?? []),
        courseModules: List<CourseModule>.from(json["course_modules"]?.map((x) => CourseModule.fromJson(x)) ?? []),
        meetYourInstructor: List<MeetYourInstructor>.from(json["meet_your_instructor"]?.map((x) => MeetYourInstructor.fromJson(x)) ?? []),
        startCourse: List<CourseModule>.from(json["start_course"]?.map((x) => CourseModule.fromJson(x)) ?? []),
    );

    Map<String, dynamic> toJson() => {
        "course_data": List<dynamic>.from(courseData.map((x) => x.toJson())),
        "course_modules": List<dynamic>.from(courseModules.map((x) => x.toJson())),
        "meet_your_instructor": List<dynamic>.from(meetYourInstructor.map((x) => x.toJson())),
        "start_course": List<dynamic>.from(startCourse.map((x) => x.toJson())),
    };
}

class CourseDatum {
    String courseId;
    String instructor;
    String name;
    String shortDescription;
    List<String> learnings;
    String slug;
    dynamic courseCost;
    String duration;
    String type;
    String contextOfCourse;
    String trailorVideo;
    String bts;
    String courseBannerDesktop;
    String courseBannerMobile;
    dynamic discountPercentage;
    dynamic masterId;
    String masterName;
    String mastersBio;
    String masterProfilePhoto;
    String catname;
    List<String> topicCovered;
    dynamic amountWithDiscount;
    dynamic noOfModules;
    bool savedFlag;
    CourseDatum({
        required this.courseId,
        required this.instructor,
        required this.name,
        required this.shortDescription,
        required this.learnings,
        required this.slug,
        required this.courseCost,
        required this.duration,
        required this.type,
        required this.contextOfCourse,
        required this.trailorVideo,
        required this.bts,
        required this.courseBannerDesktop,
        required this.courseBannerMobile,
        required this.discountPercentage,
        required this.masterId,
        required this.masterName,
        required this.mastersBio,
        required this.masterProfilePhoto,
        required this.catname,
        required this.topicCovered,
        required this.amountWithDiscount,
        required this.noOfModules,
        required this.savedFlag,
    });

    factory CourseDatum.fromJson(Map<String, dynamic> json) => CourseDatum(
        courseId: json["course_id"] ?? '',
        instructor: json["instructor"] ?? '',
        name: json["name"] ?? '',
        shortDescription: json["short_description"] ?? '',
        learnings: List<String>.from(json["learnings"]?.map((x) => x) ?? []),
        slug: json["slug"] ?? '',
        courseCost: json["course_cost"] ?? 0,
        duration: json["duration"] ?? '',
        type: json["type"] ?? '',
        contextOfCourse: json["context_of_course"] ?? '',
        trailorVideo: json["trailor_video"] ?? '',
        bts: json["bts"] ?? '',
        courseBannerDesktop: json["course_banner_desktop"] ?? '',
        courseBannerMobile: json["course_banner_mobile"] ?? '',
        discountPercentage: json["discount_percentage"] ?? 0,
        masterId: json["master_id"] ?? 0,
        masterName: json["master_name"] ?? '',
        mastersBio: json["masters_bio"] ?? '',
        masterProfilePhoto: json["master_profile_photo"] ?? '',
        catname: json["catname"] ?? '',
        topicCovered: List<String>.from(json["topic_covered"]?.map((x) => x) ?? []),
        amountWithDiscount: json["amount_with_discount"] ?? 0,
        noOfModules: json["no_of_modules"] ?? 0,
        savedFlag: json["saved_flag"] ?? false,
    );

    Map<String, dynamic> toJson() => {
        "course_id": courseId,
        "instructor": instructor,
        "name": name,
        "short_description": shortDescription,
        "learnings": List<dynamic>.from(learnings.map((x) => x)),
        "slug": slug,
        "course_cost": courseCost,
        "duration": duration,
        "type": type,
        "context_of_course": contextOfCourse,
        "trailor_video": trailorVideo,
        "bts": bts,
        "course_banner_desktop": courseBannerDesktop,
        "course_banner_mobile": courseBannerMobile,
        "discount_percentage": discountPercentage,
        "master_id": masterId,
        "master_name": masterName,
        "masters_bio": mastersBio,
        "master_profile_photo": masterProfilePhoto,
        "catname": catname,
        "topic_covered": List<dynamic>.from(topicCovered.map((x) => x)),
        "amount_with_discount": amountWithDiscount,
        "no_of_modules": noOfModules,
        "saved_flag": savedFlag,
    };
}

class CourseModule {
    String courseTopicId;
    String topic;
    String description;
    String courseTopicSlug;
    String videoDuration;
    String topicVideo;
    String freeVideo;
    String watchTime;
    dynamic completionPercentage;

    CourseModule({
        required this.courseTopicId,
        required this.topic,
        required this.description,
        required this.courseTopicSlug,
        required this.videoDuration,
        required this.topicVideo,
        required this.freeVideo,
        required this.watchTime,
        required this.completionPercentage,
    });

    factory CourseModule.fromJson(Map<String, dynamic> json) => CourseModule(
        courseTopicId: json["course_topic_id"] ?? '',
        topic: json["topic"] ?? '',
        description: json["description"] ?? '',
        courseTopicSlug: json["course_topic_slug"] ?? '',
        videoDuration: json["video_duration"] ?? '',
        topicVideo: json["topic_video"] ?? '',
        freeVideo: json["free_video"] ?? '',
        watchTime: json["watchTime"] ?? '',
        completionPercentage: json["completion_percentage"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "course_topic_id": courseTopicId,
        "topic": topic,
        "description": description,
        "course_topic_slug": courseTopicSlug,
        "video_duration": videoDuration,
        "topic_video": topicVideo,
        "free_video": freeVideo,
        "watchTime": watchTime,
        "completion_percentage": completionPercentage,
    };
}

class MeetYourInstructor {
    String masterName;
    String slug;
    String description;
    String masterPhoto;

    MeetYourInstructor({
        required this.masterName,
        required this.slug,
        required this.description,
        required this.masterPhoto,
    });

    factory MeetYourInstructor.fromJson(Map<String, dynamic> json) => MeetYourInstructor(
        masterName: json["master_name"] ?? '',
        slug: json["slug"] ?? '',
        description: json["description"] ?? '',
        masterPhoto: json["master_photo"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "master_name": masterName,
        "slug": slug,
        "description": description,
        "master_photo": masterPhoto,
    };
}


// import 'dart:convert';

// ParticularCoursesResponse particularCoursesResponseFromJson(String str) => ParticularCoursesResponse.fromJson(json.decode(str));

// String particularCoursesResponseToJson(ParticularCoursesResponse data) => json.encode(data.toJson());

// class ParticularCoursesResponse {
//   bool status;
//   String message;
//   List<Datum> data;

//   ParticularCoursesResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory ParticularCoursesResponse.fromJson(Map<String, dynamic> json) => ParticularCoursesResponse(
//     status: json["status"] ?? false,
//     message: json["message"] ?? '',
//     data: json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );

//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }

// class Datum {
//   List<CourseDatum> courseData;
//   List<CourseModule> courseModules;
//   List<MeetYourInstructor> meetYourInstructor;
//   List<CourseModule> startCourse;

//   Datum({
//     required this.courseData,
//     required this.courseModules,
//     required this.meetYourInstructor,
//     required this.startCourse,
//   });

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     courseData: json["course_data"] == null ? [] : List<CourseDatum>.from(json["course_data"].map((x) => CourseDatum.fromJson(x))),
//     courseModules: json["course_modules"] == null ? [] : List<CourseModule>.from(json["course_modules"].map((x) => CourseModule.fromJson(x))),
//     meetYourInstructor: json["meet_your_instructor"] == null ? [] : List<MeetYourInstructor>.from(json["meet_your_instructor"].map((x) => MeetYourInstructor.fromJson(x))),
//     startCourse: json["start_course"] == null ? [] : List<CourseModule>.from(json["start_course"].map((x) => CourseModule.fromJson(x))),
//   );

//   Map<String, dynamic> toJson() => {
//     "course_data": List<dynamic>.from(courseData.map((x) => x.toJson())),
//     "course_modules": List<dynamic>.from(courseModules.map((x) => x.toJson())),
//     "meet_your_instructor": List<dynamic>.from(meetYourInstructor.map((x) => x.toJson())),
//     "start_course": List<dynamic>.from(startCourse.map((x) => x.toJson())),
//   };
// }

// class CourseDatum {
//   String courseId;
//   String instructor;
//   String name;
//   String shortDescription;
//   List<String> learnings;
//   String slug;
//   dynamic courseCost;
//   String duration;
//   String type;
//   String contextOfCourse;
//   String trailorVideo;
//   String bts;
//   String courseBannerDesktop;
//   String courseBannerMobile;
//   dynamic discountPercentage;
//   dynamic masterId;
//   String masterName;
//   String mastersBio;
//   String masterProfilePhoto;
//   String catname;
//   List<String> topicCovered;
//   dynamic amountWithDiscount;
//   dynamic noOfModules;

//   CourseDatum({
//     required this.courseId,
//     required this.instructor,
//     required this.name,
//     required this.shortDescription,
//     required this.learnings,
//     required this.slug,
//     required this.courseCost,
//     required this.duration,
//     required this.type,
//     required this.contextOfCourse,
//     required this.trailorVideo,
//     required this.bts,
//     required this.courseBannerDesktop,
//     required this.courseBannerMobile,
//     required this.discountPercentage,
//     required this.masterId,
//     required this.masterName,
//     required this.mastersBio,
//     required this.masterProfilePhoto,
//     required this.catname,
//     required this.topicCovered,
//     required this.amountWithDiscount,
//     required this.noOfModules,
//   });

//   factory CourseDatum.fromJson(Map<String, dynamic> json) => CourseDatum(
//     courseId: json["course_id"] ?? '',
//     instructor: json["instructor"] ?? '',
//     name: json["name"] ?? '',
//     shortDescription: json["short_description"] ?? '',
//     learnings: json["learnings"] == null ? [] : List<String>.from(json["learnings"].map((x) => x)),
//     slug: json["slug"] ?? '',
//     courseCost: json["course_cost"] ?? 0,
//     duration: json["duration"] ?? '',
//     type: json["type"] ?? '',
//     contextOfCourse: json["context_of_course"] ?? '',
//     trailorVideo: json["trailor_video"] ?? '',
//     bts: json["bts"] ?? '',
//     courseBannerDesktop: json["course_banner_desktop"] ?? '',
//     courseBannerMobile: json["course_banner_mobile"] ?? '',
//     discountPercentage: json["discount_percentage"] ?? 0,
//     masterId: json["master_id"] ?? 0,
//     masterName: json["master_name"] ?? '',
//     mastersBio: json["masters_bio"] ?? '',
//     masterProfilePhoto: json["master_profile_photo"] ?? '',
//     catname: json["catname"] ?? '',
//     topicCovered: json["topic_covered"] == null ? [] : List<String>.from(json["topic_covered"].map((x) => x)),
//     amountWithDiscount: json["amount_with_discount"] ?? 0,
//     noOfModules: json["no_of_modules"] ?? 0,
//   );

//   Map<String, dynamic> toJson() => {
//     "course_id": courseId,
//     "instructor": instructor,
//     "name": name,
//     "short_description": shortDescription,
//     "learnings": List<dynamic>.from(learnings.map((x) => x)),
//     "slug": slug,
//     "course_cost": courseCost,
//     "duration": duration,
//     "type": type,
//     "context_of_course": contextOfCourse,
//     "trailor_video": trailorVideo,
//     "bts": bts,
//     "course_banner_desktop": courseBannerDesktop,
//     "course_banner_mobile": courseBannerMobile,
//     "discount_percentage": discountPercentage,
//     "master_id": masterId,
//     "master_name": masterName,
//     "masters_bio": mastersBio,
//     "master_profile_photo": masterProfilePhoto,
//     "catname": catname,
//     "topic_covered": List<dynamic>.from(topicCovered.map((x) => x)),
//     "amount_with_discount": amountWithDiscount,
//     "no_of_modules": noOfModules,
//   };
// }

// class CourseModule {
//   String courseTopicId;
//   String topic;
//   String description;
//   String courseTopicSlug;
//   String videoDuration;
//   String topicVideo;
//   String freeVideo;
//   String watchTime;

//   CourseModule({
//     required this.courseTopicId,
//     required this.topic,
//     required this.description,
//     required this.courseTopicSlug,
//     required this.videoDuration,
//     required this.topicVideo,
//     required this.freeVideo,
//     required this.watchTime,
//   });

//   factory CourseModule.fromJson(Map<String, dynamic> json) => CourseModule(
//     courseTopicId: json["course_topic_id"] ?? '',
//     topic: json["topic"] ?? '',
//     description: json["description"] ?? '',
//     courseTopicSlug: json["course_topic_slug"] ?? '',
//     videoDuration: json["video_duration"] ?? '',
//     topicVideo: json["topic_video"] ?? '',
//     freeVideo: json["free_video"] ?? '',
//     watchTime: json["watchTime"] ?? '',
//   );

//   Map<String, dynamic> toJson() => {
//     "course_topic_id": courseTopicId,
//     "topic": topic,
//     "description": description,
//     "course_topic_slug": courseTopicSlug,
//     "video_duration": videoDuration,
//     "topic_video": topicVideo,
//     "free_video": freeVideo,
//     "watchTime": watchTime,
//   };
// }

// class MeetYourInstructor {
//   String masterName;
//   String slug;
//   String description;
//   String masterPhoto;

//   MeetYourInstructor({
//     required this.masterName,
//     required this.slug,
//     required this.description,
//     required this.masterPhoto,
//   });

//   factory MeetYourInstructor.fromJson(Map<String, dynamic> json) => MeetYourInstructor(
//     masterName: json["master_name"] ?? '',
//     slug: json["slug"] ?? '',
//     description: json["description"] ?? '',
//     masterPhoto: json["master_photo"] ?? '',
//   );

//   Map<String, dynamic> toJson() => {
//     "master_name": masterName,
//     "slug": slug,
//     "description": description,
//     "master_photo": masterPhoto,
//   };
// }
