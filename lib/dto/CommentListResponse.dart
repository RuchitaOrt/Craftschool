import 'dart:convert';

CommentListResponse commentListResponseFromJson(String str) =>
    CommentListResponse.fromJson(json.decode(str));

String commentListResponseToJson(CommentListResponse data) =>
    json.encode(data.toJson());

class CommentListResponse {
  bool? status;
  String? message;
  List<Comment>? comments;

  CommentListResponse({
    this.status,
    this.message,
    this.comments,
  });

  factory CommentListResponse.fromJson(Map<String, dynamic> json) =>
      CommentListResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        comments: json["comments"] != null
            ? List<Comment>.from(
                json["comments"].map((x) => Comment.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status ?? false,
        "message": message ?? "",
        "comments": comments != null
            ? List<dynamic>.from(comments!.map((x) => x.toJson()))
            : [],
      };
}

class Comment {
  int? postId;
  int? commentId;
  int? customerId;
  String? customerName;
  String? userProfilePic;
  String? comment;
  bool? hasCommentLiked;
  String? commentLikeCount;
  String? createdAt;
  String? timeAgo;

  Comment({
    this.postId,
    this.commentId,
    this.customerId,
    this.customerName,
    this.userProfilePic,
    this.comment,
    this.hasCommentLiked,
    this.commentLikeCount,
    this.createdAt,
    this.timeAgo,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        postId: json["post_id"] ?? 0,
        commentId: json["comment_id"] ?? 0,
        customerId: json["customer_id"] ?? 0,
        customerName: json["customer_name"] ?? "",
        userProfilePic: json["user_profile_pic"] ?? "",
        comment: json["comment"] ?? "",
        hasCommentLiked: json["has_comment_liked"] ?? false,
        commentLikeCount: json["comment_like_count"] ?? "0",
        createdAt: json["created_at"] ?? "",
        timeAgo: json["time_ago"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId ?? 0,
        "comment_id": commentId ?? 0,
        "customer_id": customerId ?? 0,
        "customer_name": customerName ?? "",
        "user_profile_pic": userProfilePic ?? "",
        "comment": comment ?? "",
        "has_comment_liked": hasCommentLiked ?? false,
        "comment_like_count": commentLikeCount ?? "0",
        "created_at": createdAt ?? "",
        "time_ago": timeAgo ?? "",
      };
}

// import 'dart:convert';

// CommentListResponse commentListResponseFromJson(String str) =>
//     CommentListResponse.fromJson(json.decode(str));

// String commentListResponseToJson(CommentListResponse data) =>
//     json.encode(data.toJson());

// class CommentListResponse {
//   bool status;
//   String message;
//   List<Comment> comments;

//   CommentListResponse({
//     required this.status,
//     required this.message,
//     required this.comments,
//   });

//   factory CommentListResponse.fromJson(Map<String, dynamic> json) =>
//       CommentListResponse(
//         status: json["status"] ?? false, // Default to false if null
//         message: json["message"] ?? "", // Default to empty string if null
//         comments: json["comments"] != null
//             ? List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x)))
//             : [],
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
//       };
// }

// class Comment {
//   int postId;
//   int commentId;
//   int customerId;
//   String customerName;
//   String comment;
//    String likeCount;
//   bool hasCommentLiked;

//   Comment({
//     required this.postId,
//     required this.commentId,
//     required this.customerId,
//     required this.customerName,
//     required this.comment,
//         required this.likeCount,
//     required this.hasCommentLiked,
//   });

//   factory Comment.fromJson(Map<String, dynamic> json) => Comment(
//         postId: json["post_id"] ?? 0, // Default to 0 if null
//         commentId: json["comment_id"] ?? 0, // Default to 0 if null
//         customerId: json["customer_id"] ?? 0, // Default to 0 if null
//         customerName: json["customer_name"] ?? "", // Default to empty string if null
//         comment: json["comment"] ?? "", // Default to empty string if null
//         hasCommentLiked: json["has_comment_liked"] ?? false, // Default to false if null
//           likeCount: json["like_count"] ?? "0",
//       );

//   Map<String, dynamic> toJson() => {
//         "post_id": postId,
//         "comment_id": commentId,
//         "customer_id": customerId,
//         "customer_name": customerName,
//         "comment": comment,
//          "like_count": likeCount,
//         "has_comment_liked": hasCommentLiked,
//       };
// }
