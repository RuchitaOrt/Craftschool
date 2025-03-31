import 'dart:convert';

GetAllPlanResponse getAllPlanResponseFromJson(String str) => GetAllPlanResponse.fromJson(json.decode(str));

String getAllPlanResponseToJson(GetAllPlanResponse data) => json.encode(data.toJson());

class GetAllPlanResponse {
  bool status;
  String message;
  List<Datum> data;

  GetAllPlanResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAllPlanResponse.fromJson(Map<String, dynamic> json) => GetAllPlanResponse(
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
  String id;
  String planName;
  String cost;
  String planType;
  dynamic simaltaneousDevicesAccessible;
  dynamic downloadDevices;
  String courses;
  String craftschoolSessions;
  String communityAccess;
  String publish;
  String status;
  dynamic ordering;
  String? courseNames;
  String supportedDevices;

  Datum({
    required this.id,
    required this.planName,
    required this.cost,
    required this.planType,
    required this.simaltaneousDevicesAccessible,
    required this.downloadDevices,
    required this.courses,
    required this.craftschoolSessions,
    required this.communityAccess,
    required this.publish,
    required this.status,
    required this.ordering,
    required this.courseNames,
    required this.supportedDevices,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    planName: json["plan_name"] ?? "",
    cost: json["cost"] ?? "",
    planType: json["plan_type"] ?? "",
    simaltaneousDevicesAccessible: json["simaltaneous_devices_accessible"],
    downloadDevices: json["download_devices"],
    courses: json["courses"] ?? "",
    craftschoolSessions: json["craftschool_sessions"] ?? "",
    communityAccess: json["community_access"] ?? "",
    publish: json["publish"] ?? "",
    status: json["status"] ?? "",
    ordering: json["ordering"],
    courseNames: json["course_names"],
    supportedDevices: json["supported_devices"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "plan_name": planName,
    "cost": cost,
    "plan_type": planType,
    "simaltaneous_devices_accessible": simaltaneousDevicesAccessible,
    "download_devices": downloadDevices,
    "courses": courses,
    "craftschool_sessions": craftschoolSessions,
    "community_access": communityAccess,
    "publish": publish,
    "status": status,
    "ordering": ordering,
    "course_names": courseNames,
    "supported_devices": supportedDevices,
  };
}
