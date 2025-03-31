import 'dart:convert';

TestimonialResponse testimonialResponseFromJson(String str) =>
    TestimonialResponse.fromJson(json.decode(str));

String testimonialResponseToJson(TestimonialResponse data) =>
    json.encode(data.toJson());

class TestimonialResponse {
  bool? status;
  String? message;
  List<Datum>? data;

  TestimonialResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TestimonialResponse.fromJson(Map<String, dynamic> json) =>
      TestimonialResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status ?? false,
        "message": message ?? "",
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : [],
      };
}

class Datum {
  String? description;
  int? rating;
  String? name;
  String? photo;
  String? testimonialCreate;

  Datum({
    this.description,
    this.rating,
    this.name,
    this.photo,
    this.testimonialCreate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        description: json["description"] ?? "",
        rating: json["rating"] ?? 0,
        name: json["name"] ?? "",
        photo: json["photo"] ?? "",
        testimonialCreate: json["testimonial_create"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "description": description ?? "",
        "rating": rating ?? 0,
        "name": name ?? "",
        "photo": photo ?? "",
        "testimonial_create": testimonialCreate ?? "",
      };
}

// import 'dart:convert';

// TestimonialResponse testimonialResponseFromJson(String str) => TestimonialResponse.fromJson(json.decode(str));

// String testimonialResponseToJson(TestimonialResponse data) => json.encode(data.toJson());

// class TestimonialResponse {
//   bool status;
//   String message;
//   List<Datum> data;

//   TestimonialResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory TestimonialResponse.fromJson(Map<String, dynamic> json) => TestimonialResponse(
//     status: json["status"] ?? false,
//     message: json["message"] ?? '',
//     data: List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
//   );

//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }

// class Datum {
//   String comments;
//   dynamic rating;
//   String? userName;
//   String? blogCreate;

//   Datum({
//     required this.comments,
//     required this.rating,
//     this.userName,
//     this.blogCreate,
//   });

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     comments: json["comments"] ?? '',
//     rating: json["rating"] ?? 0,
//     userName: json["user_name"] as String? ?? '',
//     blogCreate: json["blog_create"] as String? ?? '',
//   );

//   Map<String, dynamic> toJson() => {
//     "comments": comments,
//     "rating": rating,
//     "user_name": userName,
//     "blog_create": blogCreate,
//   };
// }
