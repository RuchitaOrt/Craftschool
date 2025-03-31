import 'dart:convert';

SavedCoursesResponse savedCoursesResponseFromJson(String str) =>
    SavedCoursesResponse.fromJson(json.decode(str));

String savedCoursesResponseToJson(SavedCoursesResponse data) =>
    json.encode(data.toJson());

class SavedCoursesResponse {
  bool status;
  String message;
  List<dynamic> errors;

  SavedCoursesResponse({
    required this.status,
    required this.message,
    required this.errors,
  });

  factory SavedCoursesResponse.fromJson(Map<String, dynamic> json) =>
      SavedCoursesResponse(
        status: json["status"] ?? false, // Default to false if null
        message: json["message"] ?? "", // Default to empty string if null
        errors: json["errors"] != null
            ? List<dynamic>.from(json["errors"].map((x) => x))
            : [], // Default to an empty list if null
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "errors": List<dynamic>.from(errors.map((x) => x)),
      };
}
