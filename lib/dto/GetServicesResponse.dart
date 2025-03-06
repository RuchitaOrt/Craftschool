// To parse this JSON data, do
//
//     final getServicesResponse = getServicesResponseFromJson(jsonString);

import 'dart:convert';

GetServicesResponse getServicesResponseFromJson(String str) => GetServicesResponse.fromJson(json.decode(str));

String getServicesResponseToJson(GetServicesResponse data) => json.encode(data.toJson());

class GetServicesResponse {
    bool status;
    String message;
    List<Datum> data;

    GetServicesResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetServicesResponse.fromJson(Map<String, dynamic> json) => GetServicesResponse(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String title;
    String description;
    String media1;

    Datum({
        required this.id,
        required this.title,
        required this.description,
        required this.media1,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        media1: json["media1"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "media1": media1,
    };
}
