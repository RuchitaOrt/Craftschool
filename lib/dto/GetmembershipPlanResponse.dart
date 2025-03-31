import 'dart:convert';

GetmembershipPlanResponse getmembershipPlanResponseFromJson(String str) => GetmembershipPlanResponse.fromJson(json.decode(str));

String getmembershipPlanResponseToJson(GetmembershipPlanResponse data) => json.encode(data.toJson());

class GetmembershipPlanResponse {
  bool status;
  String message;
  List<Datum> data;

  GetmembershipPlanResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetmembershipPlanResponse.fromJson(Map<String, dynamic> json) => GetmembershipPlanResponse(
    status: json["status"] ?? false,
    message: json["message"] ?? '',
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
  List<CurrentPlanInfo> currentPlanInfo;
  List<CurrentPlanInfo> planList;

  Datum({
    required this.currentPlanInfo,
    required this.planList,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    currentPlanInfo: json["current_plan_info"] == null
        ? []
        : List<CurrentPlanInfo>.from(json["current_plan_info"].map((x) => CurrentPlanInfo.fromJson(x))),
    planList: json["plan_list"] == null
        ? []
        : List<CurrentPlanInfo>.from(json["plan_list"].map((x) => CurrentPlanInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "current_plan_info": List<dynamic>.from(currentPlanInfo.map((x) => x.toJson())),
    "plan_list": List<dynamic>.from(planList.map((x) => x.toJson())),
  };
}

class CurrentPlanInfo {
  String id;
  String planName;
  String cost;

  CurrentPlanInfo({
    required this.id,
    required this.planName,
    required this.cost,
  });

  factory CurrentPlanInfo.fromJson(Map<String, dynamic> json) => CurrentPlanInfo(
    id: json["id"] ?? '',
    planName: json["plan_name"] ?? '',
    cost: json["cost"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "plan_name": planName,
    "cost": cost,
  };
}
