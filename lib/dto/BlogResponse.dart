import 'dart:convert';

BlogResponse blogResponseFromJson(String str) => BlogResponse.fromJson(json.decode(str));

String blogResponseToJson(BlogResponse data) => json.encode(data.toJson());

class BlogResponse {
  bool status;
  int total;
  String message;
  List<Datum> data;

  BlogResponse({
    required this.status,
    required this.total,
    required this.message,
    required this.data,
  });

  factory BlogResponse.fromJson(Map<String, dynamic> json) => BlogResponse(
    status: json["status"] ?? false,
    total: json["total"] ?? 0,
    message: json["message"] ?? "",
    data: json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total": total,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String title;
  String blogsSlug;
  String blogImage;
  dynamic readTime;
  String description;
  String catName;
  dynamic blogCreateDate;

  Datum({
    required this.title,
    required this.blogsSlug,
    required this.blogImage,
    required this.readTime,
    required this.description,
    required this.catName,
    required this.blogCreateDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"] ?? "",
    blogsSlug: json["blogs_slug"] ?? "",
    blogImage: json["blog_image"] ?? "",
    readTime: json["read_time"] ?? "",
    description: json["description"] ?? "",
    catName: json["cat_name"] ?? "",
    blogCreateDate: json["blog_create_date"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "blogs_slug": blogsSlug,
    "blog_image": blogImage,
    "read_time": readTime,
    "description": description,
    "cat_name": catName,
    "blog_create_date": blogCreateDate,
  };
}
