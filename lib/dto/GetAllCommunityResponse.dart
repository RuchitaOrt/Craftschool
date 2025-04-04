import 'dart:convert';

GetAllCommunityResponse getAllCommunityResponseFromJson(String str) =>
    GetAllCommunityResponse.fromJson(json.decode(str));

String getAllCommunityResponseToJson(GetAllCommunityResponse data) =>
    json.encode(data.toJson());

class GetAllCommunityResponse {
  bool status;
  dynamic total;
  List<Datum> data;
  String message;

  GetAllCommunityResponse({
    required this.status,
    required this.total,
    required this.data,
    required this.message,
  });

  factory GetAllCommunityResponse.fromJson(Map<String, dynamic> json) =>
      GetAllCommunityResponse(
        status: json["status"] ?? false,
        total: json["total"] ?? 0,
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : [],
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "total": total,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  dynamic id;
  String customerName;
  String createdAt;
  String? timeAgo;
  String post;
  dynamic customerId;
   String userProfilePic;
  List<Media> medias;
  String likeCount;
  String commentCount;
  bool hasLiked;
  bool hasCommented;
  bool hasSaved;

  Datum({
    required this.id,
    required this.customerName,
    required this.createdAt,
    required this.userProfilePic,
    required this.post,
    required this.customerId,
    required this.medias,
    required this.likeCount,
    required this.commentCount,
    required this.hasLiked,
    required this.hasCommented,
    required this.hasSaved,
    this.timeAgo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? 0,
        customerName: json["customer_name"] ?? '',
        createdAt: json["created_at"] ?? '',
        post: json["post"] ?? '',
        customerId: json["customer_id"] ?? 0,
        timeAgo: json["time_ago"] ?? "",
        medias: json["medias"] != null
            ? List<Media>.from(json["medias"].map((x) => Media.fromJson(x)))
            : [],
        likeCount: json["like_count"] ?? '0',
        commentCount: json["comment_count"] ?? '0',
        hasLiked: json["has_liked"] ?? false,
        hasCommented: json["has_commented"] ?? false,
        hasSaved: json["has_saved"] ?? false,
        userProfilePic: json["user_profile_pic"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_name": customerName,
        "created_at": createdAt,
        "post": post,
        "customer_id": customerId,
        "medias": List<dynamic>.from(medias.map((x) => x.toJson())),
        "like_count": likeCount,
        "comment_count": commentCount,
        "has_liked": hasLiked,
        "has_commented": hasCommented,
        "user_profile_pic": userProfilePic ?? "",
        "has_saved": hasSaved,
         "time_ago": timeAgo ?? "",
      };
}

class Media {
  dynamic mediaId;
  String mediaUrl;

  Media({
    required this.mediaId,
    required this.mediaUrl,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        mediaId: json["media_id"] ?? 0,
        mediaUrl: json["media_url"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "media_id": mediaId,
        "media_url": mediaUrl,
      };
}

// import 'dart:convert';

// GetAllCommunityResponse getAllCommunityResponseFromJson(String str) =>
//     GetAllCommunityResponse.fromJson(json.decode(str));

// String getAllCommunityResponseToJson(GetAllCommunityResponse data) =>
//     json.encode(data.toJson());

// class GetAllCommunityResponse {
//   bool status;
//   int total;
//   List<Datum> data;
//   String message;

//   GetAllCommunityResponse({
//     required this.status,
//     required this.total,
//     required this.data,
//     required this.message,
//   });

//   factory GetAllCommunityResponse.fromJson(Map<String, dynamic> json) =>
//       GetAllCommunityResponse(
//         status: json["status"] ?? false,
//         total: json["total"] ?? 0,
//         data: List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
//         message: json["message"] ?? "",
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "total": total,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "message": message,
//       };
// }

// class Datum {
//   int id;
//   String customerName;
//   String createdAt;
//   String post;
//   int customerId;
//   List<String> medias;
//   String likeCount;
//   String commentCount;
//   bool hasLiked;
//   bool hasCommented;
//   bool hasSaved;

//   Datum({
//     required this.id,
//     required this.customerName,
//     required this.createdAt,
//     required this.post,
//     required this.customerId,
//     required this.medias,
//     required this.likeCount,
//     required this.commentCount,
//     required this.hasLiked,
//     required this.hasCommented,
//     required this.hasSaved,
//   });

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"] ?? 0,
//         customerName: json["customer_name"] ?? "",
//         createdAt: json["created_at"] ?? "",
//         post: json["post"] ?? "",
//         customerId: json["customer_id"] ?? 0,
//         medias: List<String>.from(json["medias"]?.map((x) => x) ?? []),
//         likeCount: json["like_count"] ?? "0",
//         commentCount: json["comment_count"] ?? "0",
//         hasLiked: json["has_liked"] ?? false,
//         hasCommented: json["has_commented"] ?? false,
//         hasSaved: json["has_saved"] ?? false,
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "customer_name": customerName,
//         "created_at": createdAt,
//         "post": post,
//         "customer_id": customerId,
//         "medias": List<dynamic>.from(medias.map((x) => x)),
//         "like_count": likeCount,
//         "comment_count": commentCount,
//         "has_liked": hasLiked,
//         "has_commented": hasCommented,
//         "has_saved": hasSaved,
//       };
// }
