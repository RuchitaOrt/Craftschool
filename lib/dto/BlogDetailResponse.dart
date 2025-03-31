// To parse this JSON data, do
//
//     final blogDetailResponse = blogDetailResponseFromJson(jsonString);

import 'dart:convert';

BlogDetailResponse blogDetailResponseFromJson(String str) => BlogDetailResponse.fromJson(json.decode(str));

String blogDetailResponseToJson(BlogDetailResponse data) => json.encode(data.toJson());

class BlogDetailResponse {
    bool status;
    String message;
    List<Datum> data;
    List<Datum> relatedBlogs;
    List<Datum> latestBlogs;

    BlogDetailResponse({
        required this.status,
        required this.message,
        required this.data,
        required this.relatedBlogs,
        required this.latestBlogs,
    });

    factory BlogDetailResponse.fromJson(Map<String, dynamic> json) => BlogDetailResponse(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        relatedBlogs: List<Datum>.from(json["related_blogs"].map((x) => Datum.fromJson(x))),
        latestBlogs: List<Datum>.from(json["latest_blogs"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "related_blogs": List<dynamic>.from(relatedBlogs.map((x) => x.toJson())),
        "latest_blogs": List<dynamic>.from(latestBlogs.map((x) => x.toJson())),
    };
}

class Datum {
    String title;
    List<String> tags;
    DateTime createdAt;
    String slug;
    int? categoryId;
    String blogImage;
    String description;
    String catName;
    String readTime;

    Datum({
        required this.title,
        required this.tags,
        required this.createdAt,
        required this.slug,
        this.categoryId,
        required this.blogImage,
        required this.description,
        required this.catName,
        required this.readTime,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        slug: json["slug"],
        categoryId: json["category_id"],
        blogImage: json["blog_image"],
        description: json["description"],
        catName: json["cat_name"],
        readTime: json["read_time"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "slug": slug,
        "category_id": categoryId,
        "blog_image": blogImage,
        "description": description,
        "cat_name": catName,
        "read_time": readTime,
    };
}

// import 'dart:convert';

// BlogDetailResponse blogDetailResponseFromJson(String str) =>
//     BlogDetailResponse.fromJson(json.decode(str));

// String blogDetailResponseToJson(BlogDetailResponse data) =>
//     json.encode(data.toJson());

// class BlogDetailResponse {
//   bool status;
//   String message;
//   List<Datum> data;
//   List<Blog> relatedBlogs;
//   List<Blog> latestBlogs;

//   BlogDetailResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//     required this.relatedBlogs,
//     required this.latestBlogs,
//   });

//   factory BlogDetailResponse.fromJson(Map<String, dynamic> json) =>
//       BlogDetailResponse(
//         status: json["status"] ?? false,
//         message: json["message"] ?? "",
//         data: json["data"] == null
//             ? []
//             : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         relatedBlogs: json["related_blogs"] == null
//             ? []
//             : List<Blog>.from(json["related_blogs"].map((x) => Blog.fromJson(x))),
//         latestBlogs: json["latest_blogs"] == null
//             ? []
//             : List<Blog>.from(json["latest_blogs"].map((x) => Blog.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "related_blogs": List<dynamic>.from(relatedBlogs.map((x) => x.toJson())),
//         "latest_blogs": List<dynamic>.from(latestBlogs.map((x) => x.toJson())),
//       };
// }

// class Datum {
//   String title;
//   String tags;
//   DateTime createdAt;
//   String slug;
//   int categoryId;
//   String blogImage;
//   String description;
//   String catName;
//   String readTime;

//   Datum({
//     required this.title,
//     required this.tags,
//     required this.createdAt,
//     required this.slug,
//     required this.categoryId,
//     required this.blogImage,
//     required this.description,
//     required this.catName,
//     required this.readTime,
//   });

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         title: json["title"] ?? "",
//         tags: json["tags"] ?? "",
//         createdAt: json["created_at"] == null
//             ? DateTime.now()
//             : DateTime.parse(json["created_at"]),
//         slug: json["slug"] ?? "",
//         categoryId: json["category_id"] ?? 0,
//         blogImage: json["blog_image"] ?? "",
//         description: json["description"] ?? "",
//         catName: json["cat_name"] ?? "",
//         readTime: json["read_time"] ?? "",
//       );

//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "tags": tags,
//         "created_at": createdAt.toIso8601String(),
//         "slug": slug,
//         "category_id": categoryId,
//         "blog_image": blogImage,
//         "description": description,
//         "cat_name": catName,
//         "read_time": readTime,
//       };
// }

// class Blog {
//   String title;
//   String tags;
//   DateTime createdAt;
//   String slug;
//   String blogImage;
//   String catName;

//   Blog({
//     required this.title,
//     required this.tags,
//     required this.createdAt,
//     required this.slug,
//     required this.blogImage,
//     required this.catName,
//   });

//   factory Blog.fromJson(Map<String, dynamic> json) => Blog(
//         title: json["title"] ?? "",
//         tags: json["tags"] ?? "",
//         createdAt: json["created_at"] == null
//             ? DateTime.now()
//             : DateTime.parse(json["created_at"]),
//         slug: json["slug"] ?? "",
//         blogImage: json["blog_image"] ?? "",
//         catName: json["cat_name"] ?? "",
//       );

//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "tags": tags,
//         "created_at": createdAt.toIso8601String(),
//         "slug": slug,
//         "blog_image": blogImage,
//         "cat_name": catName,
//       };
// }
