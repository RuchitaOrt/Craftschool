// To parse this JSON data, do
//
//     final customerCategoryListResponse = customerCategoryListResponseFromJson(jsonString);

import 'dart:convert';

CustomerCategoryListResponse customerCategoryListResponseFromJson(String str) => CustomerCategoryListResponse.fromJson(json.decode(str));

String customerCategoryListResponseToJson(CustomerCategoryListResponse data) => json.encode(data.toJson());

class CustomerCategoryListResponse {
    bool status;
    String message;
    List<Datum> data;

    CustomerCategoryListResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CustomerCategoryListResponse.fromJson(Map<String, dynamic> json) => CustomerCategoryListResponse(
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
    String catName;
    String slug;
    String catIcon;
    String catGreenIcon;

    Datum({
        required this.id,
        required this.catName,
        required this.slug,
        required this.catIcon,
        required this.catGreenIcon,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        catName: json["cat_name"],
        slug: json["slug"],
        catIcon: json["cat_icon"],
        catGreenIcon: json["cat_green_icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cat_name": catName,
        "slug": slug,
        "cat_icon": catIcon,
        "cat_green_icon": catGreenIcon,
    };
}
