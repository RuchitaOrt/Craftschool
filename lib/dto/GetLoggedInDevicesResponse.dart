import 'dart:convert';

GetLoggedInDevicesResponse getLoggedInDevicesResponseFromJson(String str) => GetLoggedInDevicesResponse.fromJson(json.decode(str));

String getLoggedInDevicesResponseToJson(GetLoggedInDevicesResponse data) => json.encode(data.toJson());

class GetLoggedInDevicesResponse {
  bool status;
  String message;
  List<Datum> data;

  GetLoggedInDevicesResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetLoggedInDevicesResponse.fromJson(Map<String, dynamic> json) => GetLoggedInDevicesResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.isNotEmpty ? List<dynamic>.from(data.map((x) => x.toJson())) : [],
      };
}

class Datum {
  List<DeviceInfo> deviceInfo;
  int countofdevice;

  Datum({
    required this.deviceInfo,
    required this.countofdevice,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        deviceInfo: json["deviceInfo"] != null
            ? List<DeviceInfo>.from(json["deviceInfo"].map((x) => DeviceInfo.fromJson(x)))
            : [],
        countofdevice: json["countofdevice"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "deviceInfo": deviceInfo.isNotEmpty ? List<dynamic>.from(deviceInfo.map((x) => x.toJson())) : [],
        "countofdevice": countofdevice,
      };
}

class DeviceInfo {
  String device;
  String browers;
  String lastUsedTime;
  String token;

  DeviceInfo({
    required this.device,
    required this.browers,
    required this.lastUsedTime,
    required this.token,
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> json) => DeviceInfo(
        device: json["device"] ?? "",
        browers: json["browers"] ?? "",
        lastUsedTime: json["last_used_time"] ?? "",
        token: json["token"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "device": device,
        "browers": browers,
        "last_used_time": lastUsedTime,
        "token": token,
      };
}
