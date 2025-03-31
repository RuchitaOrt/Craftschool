import 'dart:convert';

CheckSubscriptionIndividualFlowWiseInfoResponse checkSubscriptionIndividualFlowWiseInfoResponseFromJson(String str) =>
    CheckSubscriptionIndividualFlowWiseInfoResponse.fromJson(json.decode(str));

String checkSubscriptionIndividualFlowWiseInfoResponseToJson(CheckSubscriptionIndividualFlowWiseInfoResponse data) =>
    json.encode(data.toJson());

class CheckSubscriptionIndividualFlowWiseInfoResponse {
  bool status;
  String message;
  List<Datum> data;

  CheckSubscriptionIndividualFlowWiseInfoResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CheckSubscriptionIndividualFlowWiseInfoResponse.fromJson(Map<String, dynamic> json) =>
      CheckSubscriptionIndividualFlowWiseInfoResponse(
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
  dynamic clearCookies;
  dynamic customerId;
  dynamic limitDeviceLoginStatus;
  dynamic customerSubscriptionFlowStatus;
  dynamic courseStatus;
  List<PlanInfo> planInfo;

  Datum({
    required this.clearCookies,
    required this.customerId,
    required this.limitDeviceLoginStatus,
    required this.customerSubscriptionFlowStatus,
    required this.courseStatus,
    required this.planInfo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        clearCookies: json["clear_cookies"] ?? 0,
        customerId: json["customer_id"] ?? "",
        limitDeviceLoginStatus: json["limit_device_login_status"] ?? 0,
        customerSubscriptionFlowStatus: json["customer_subscription_flow_status"] ?? 0,
        courseStatus: json["course_status"] ?? 0,
        planInfo: (json["plan_info"] == null || json["plan_info"] == [])
            ? []
            : List<PlanInfo>.from(json["plan_info"].map((x) => PlanInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "clear_cookies": clearCookies,
        "customer_id": customerId,
        "limit_device_login_status": limitDeviceLoginStatus,
        "customer_subscription_flow_status": customerSubscriptionFlowStatus,
        "course_status": courseStatus,
        "plan_info": List<dynamic>.from(planInfo.map((x) => x.toJson())),
      };
}

class PlanInfo {
  dynamic planName;
  dynamic planType;
  dynamic simaltaneousDevicesAccessible;
  dynamic downloadDevices;
  dynamic communityAccess;
  dynamic subscriptionStartDate;
  dynamic subscriptionEndDate;
  dynamic planMembershipDate;
  dynamic membershipRemainingDays;
    dynamic membershipStatus;

  PlanInfo({
    required this.planName,
    required this.planType,
    required this.simaltaneousDevicesAccessible,
    required this.downloadDevices,
    required this.communityAccess,
    required this.subscriptionStartDate,
    required this.subscriptionEndDate,
    required this.planMembershipDate,
    required this.membershipRemainingDays,
        required this.membershipStatus,
  });

  factory PlanInfo.fromJson(Map<String, dynamic> json) => PlanInfo(
        planName: json["plan_name"] ?? "",
        planType: json["plan_type"] ?? "",
        simaltaneousDevicesAccessible: json["simaltaneous_devices_accessible"] ?? "",
        downloadDevices: json["download_devices"] ?? "",
        communityAccess: json["community_access"] ?? "",
        subscriptionStartDate: json["subscription_start_date"] ?? "",
        subscriptionEndDate: json["subscription_end_date"] ?? "",
        planMembershipDate: json["plan_membership_date"] ?? "",
         membershipRemainingDays: json["membership_remaining_days"] ?? 0,
        membershipStatus: json["membership_status"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "plan_name": planName,
        "plan_type": planType,
        "simaltaneous_devices_accessible": simaltaneousDevicesAccessible,
        "download_devices": downloadDevices,
        "community_access": communityAccess,
        "subscription_start_date": subscriptionStartDate,
        "subscription_end_date": subscriptionEndDate,
        "plan_membership_date": planMembershipDate,
        "membership_remaining_days": membershipRemainingDays,
        "membership_status": membershipStatus,
      };
}
