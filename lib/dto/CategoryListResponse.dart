// To parse this JSON data, do
//
//     final categoryListResponse = categoryListResponseFromJson(jsonString);

import 'dart:convert';

CategoryListResponse categoryListResponseFromJson(String str) => CategoryListResponse.fromJson(json.decode(str));

String categoryListResponseToJson(CategoryListResponse data) => json.encode(data.toJson());

class CategoryListResponse {
    bool status;
    String message;
    List<Datum> data;

    CategoryListResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CategoryListResponse.fromJson(Map<String, dynamic> json) => CategoryListResponse(
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
    String categoryName;
    int id;
    String icon;
    String greenIcon;

    Datum({
        required this.categoryName,
        required this.id,
        required this.icon,
        required this.greenIcon,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        categoryName: json["category_name"],
        id: json["id"],
        icon: json["icon"],
        greenIcon: json["green_icon"],
    );

    Map<String, dynamic> toJson() => {
        "category_name": categoryName,
        "id": id,
        "icon": icon,
        "green_icon": greenIcon,
    };
}
