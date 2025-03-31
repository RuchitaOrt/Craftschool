import 'dart:convert';

SavedPostListResponse savedPostListResponseFromJson(String str) =>
    SavedPostListResponse.fromJson(json.decode(str));

String savedPostListResponseToJson(SavedPostListResponse data) =>
    json.encode(data.toJson());

class SavedPostListResponse {
  bool status;
  String message;
  List<Datum> data;

  SavedPostListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SavedPostListResponse.fromJson(Map<String, dynamic> json) =>
      SavedPostListResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? '',
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  dynamic id;
  String customerName;
  String createdAt;
  String post;
  dynamic customerId;
  List<Media> medias;
  String likeCount;
  String commentCount;
  bool hasLiked;
  bool hasCommented;
  bool hasSaved;
  String? timeAgo;

  Datum({
    required this.id,
    required this.customerName,
    required this.createdAt,
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_name": customerName,
        "created_at": createdAt,
        "post": post,
        "customer_id": customerId,
        "medias": List<dynamic>.from(medias.map((x) => x.toJson())),
        "like_count": likeCount,
        "time_ago": timeAgo ?? "",
        "comment_count": commentCount,
        "has_liked": hasLiked,
        "has_commented": hasCommented,
        "has_saved": hasSaved,
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
