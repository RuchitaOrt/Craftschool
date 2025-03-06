// To parse this JSON data, do
//
//     final testimonialResponse = testimonialResponseFromJson(jsonString);

import 'dart:convert';

TestimonialResponse testimonialResponseFromJson(String str) => TestimonialResponse.fromJson(json.decode(str));

String testimonialResponseToJson(TestimonialResponse data) => json.encode(data.toJson());

class TestimonialResponse {
    bool status;
    String message;
    List<Datum> data;

    TestimonialResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory TestimonialResponse.fromJson(Map<String, dynamic> json) => TestimonialResponse(
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
    String comments;
    dynamic rating;
    dynamic userName;
    dynamic blogCreate;

    Datum({
        required this.comments,
        required this.rating,
        required this.userName,
        required this.blogCreate,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        comments: json["comments"],
        rating: json["rating"],
        userName: json["user_name"]!,
        blogCreate:json["blog_create"]!,
    );

    Map<String, dynamic> toJson() => {
        "comments": comments,
        "rating": rating,
        "user_name": userName,
        "blog_create": blogCreate,
    };
}


