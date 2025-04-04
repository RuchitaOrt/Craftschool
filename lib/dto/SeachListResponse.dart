import 'dart:convert';

SeachListResponse seachListResponseFromJson(String str) => SeachListResponse.fromJson(json.decode(str));

String seachListResponseToJson(SeachListResponse data) => json.encode(data.toJson());

class SeachListResponse {
  bool status;
  String message;
  List<Datum> data;

  SeachListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SeachListResponse.fromJson(Map<String, dynamic> json) => SeachListResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: (json["data"] as List?)?.map((x) => Datum.fromJson(x)).toList() ?? [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Datum {
  String courseId;
  String courseName;
  String slugName;
  int tag;
  String image;
  int masterId;
  String masterName;

  Datum({
    required this.courseId,
    required this.courseName,
    required this.slugName,
    required this.tag,
    required this.image,
    required this.masterId,
    required this.masterName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        courseId: json["course_id"] ?? "",
        courseName: json["course_name"] ?? "",
        slugName: json["slug_name"] ?? "",
        tag: json["tag"] ?? 0,
        image: json["image"] ?? "",
        masterId: json["master_id"] ?? 0,
        masterName: json["master_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "course_id": courseId,
        "course_name": courseName,
        "slug_name": slugName,
        "tag": tag,
        "image": image,
        "master_id": masterId,
        "master_name": masterName,
      };
}
