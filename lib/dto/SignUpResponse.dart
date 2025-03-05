import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
    bool status;
    String message;
    String token;
    PlanInfo planInfo;

    SignUpResponse({
        required this.status,
        required this.message,
        required this.token,
        required this.planInfo,
    });

    factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        planInfo: PlanInfo.fromJson(json["planInfo"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "planInfo": planInfo.toJson(),
    };
}

class PlanInfo {
    String planName;
    String planExpireDate;
    int status;

    PlanInfo({
        required this.planName,
        required this.planExpireDate,
        required this.status,
    });

    factory PlanInfo.fromJson(Map<String, dynamic> json) => PlanInfo(
        planName: json["plan_Name"],
        planExpireDate: json["plan_expire_date"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "plan_Name": planName,
        "plan_expire_date": planExpireDate,
        "status": status,
    };
}
