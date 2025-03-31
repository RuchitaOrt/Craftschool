import 'dart:convert';

UpdatepasswordResponse updatepasswordResponseFromJson(String str) => UpdatepasswordResponse.fromJson(json.decode(str));

String updatepasswordResponseToJson(UpdatepasswordResponse data) => json.encode(data.toJson());

class UpdatepasswordResponse {
  bool status;
  String message;
  List<dynamic> data;

  UpdatepasswordResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdatepasswordResponse.fromJson(Map<String, dynamic> json) => UpdatepasswordResponse(
    status: json["status"] ?? false,
    message: json["message"] ?? '',
    data: List<dynamic>.from(json["data"]?.map((x) => x) ?? []),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
