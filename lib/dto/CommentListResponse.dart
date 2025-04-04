import 'dart:convert';

CommentListResponse commentListResponseFromJson(String str) => CommentListResponse.fromJson(json.decode(str));

String commentListResponseToJson(CommentListResponse data) => json.encode(data.toJson());

class CommentListResponse {
    bool status;
    String message;
    List<PostDetail> postDetails;
    List<Comment> comments;

    CommentListResponse({
        required this.status,
        required this.message,
        required this.postDetails,
        required this.comments,
    });

    factory CommentListResponse.fromJson(Map<String, dynamic> json) => CommentListResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        postDetails: (json["post_details"] as List?)?.map((x) => PostDetail.fromJson(x)).toList() ?? [],
        comments: (json["comments"] as List?)?.map((x) => Comment.fromJson(x)).toList() ?? [],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "post_details": postDetails.map((x) => x.toJson()).toList(),
        "comments": comments.map((x) => x.toJson()).toList(),
    };
}

class Comment {
    int postId;
    int commentId;
    int customerId;
    String customerName;
    String userProfilePic;
    String comment;
    bool hasCommentLiked;
    String commentLikeCount;
    String createdAt;
    String timeAgo;

    Comment({
        required this.postId,
        required this.commentId,
        required this.customerId,
        required this.customerName,
        required this.userProfilePic,
        required this.comment,
        required this.hasCommentLiked,
        required this.commentLikeCount,
        required this.createdAt,
        required this.timeAgo,
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
        "post_id": postId,
        "comment_id": commentId,
        "customer_id": customerId,
        "customer_name": customerName,
        "user_profile_pic": userProfilePic,
        "comment": comment,
        "has_comment_liked": hasCommentLiked,
        "comment_like_count": commentLikeCount,
        "created_at": createdAt,
        "time_ago": timeAgo,
    };
}

class PostDetail {
    int id;
    String customerName;
    String createdAt;
    String userProfilePic;
    String timeAgo;
    String post;
    int customerId;
    List<Media> medias;
    String likeCount;
    String commentCount;
    bool hasLiked;
    bool hasCommented;
    bool hasSaved;

    PostDetail({
        required this.id,
        required this.customerName,
        required this.createdAt,
        required this.userProfilePic,
        required this.timeAgo,
        required this.post,
        required this.customerId,
        required this.medias,
        required this.likeCount,
        required this.commentCount,
        required this.hasLiked,
        required this.hasCommented,
        required this.hasSaved,
    });

    factory PostDetail.fromJson(Map<String, dynamic> json) => PostDetail(
        id: json["id"] ?? 0,
        customerName: json["customer_name"] ?? "",
        createdAt: json["created_at"] ?? "",
        userProfilePic: json["user_profile_pic"] ?? "",
        timeAgo: json["time_ago"] ?? "",
        post: json["post"] ?? "",
        customerId: json["customer_id"] ?? 0,
        medias: (json["medias"] as List?)?.map((x) => Media.fromJson(x)).toList() ?? [],
        likeCount: json["like_count"] ?? "0",
        commentCount: json["comment_count"] ?? "0",
        hasLiked: json["has_liked"] ?? false,
        hasCommented: json["has_commented"] ?? false,
        hasSaved: json["has_saved"] ?? false,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "customer_name": customerName,
        "created_at": createdAt,
        "user_profile_pic": userProfilePic,
        "time_ago": timeAgo,
        "post": post,
        "customer_id": customerId,
        "medias": medias.map((x) => x.toJson()).toList(),
        "like_count": likeCount,
        "comment_count": commentCount,
        "has_liked": hasLiked,
        "has_commented": hasCommented,
        "has_saved": hasSaved,
    };
}

class Media {
    int mediaId;
    String mediaUrl;

    Media({
        required this.mediaId,
        required this.mediaUrl,
    });

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        mediaId: json["media_id"] ?? 0,
        mediaUrl: json["media_url"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "media_id": mediaId,
        "media_url": mediaUrl,
    };
}
// import 'dart:convert';

// CommentListResponse commentListResponseFromJson(String str) =>
//     CommentListResponse.fromJson(json.decode(str));

// String commentListResponseToJson(CommentListResponse data) =>
//     json.encode(data.toJson());

// class CommentListResponse {
//   bool? status;
//   String? message;
//   List<Comment>? comments;

//   CommentListResponse({
//     this.status,
//     this.message,
//     this.comments,
//   });

//   factory CommentListResponse.fromJson(Map<String, dynamic> json) =>
//       CommentListResponse(
//         status: json["status"] ?? false,
//         message: json["message"] ?? "",
//         comments: json["comments"] != null
//             ? List<Comment>.from(
//                 json["comments"].map((x) => Comment.fromJson(x)))
//             : [],
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status ?? false,
//         "message": message ?? "",
//         "comments": comments != null
//             ? List<dynamic>.from(comments!.map((x) => x.toJson()))
//             : [],
//       };
// }

// class Comment {
//   int? postId;
//   int? commentId;
//   int? customerId;
//   String? customerName;
//   String? userProfilePic;
//   String? comment;
//   bool? hasCommentLiked;
//   String? commentLikeCount;
//   String? createdAt;
//   String? timeAgo;

//   Comment({
//     this.postId,
//     this.commentId,
//     this.customerId,
//     this.customerName,
//     this.userProfilePic,
//     this.comment,
//     this.hasCommentLiked,
//     this.commentLikeCount,
//     this.createdAt,
//     this.timeAgo,
//   });

//   factory Comment.fromJson(Map<String, dynamic> json) => Comment(
//         postId: json["post_id"] ?? 0,
//         commentId: json["comment_id"] ?? 0,
//         customerId: json["customer_id"] ?? 0,
//         customerName: json["customer_name"] ?? "",
//         userProfilePic: json["user_profile_pic"] ?? "",
//         comment: json["comment"] ?? "",
//         hasCommentLiked: json["has_comment_liked"] ?? false,
//         commentLikeCount: json["comment_like_count"] ?? "0",
//         createdAt: json["created_at"] ?? "",
//         timeAgo: json["time_ago"] ?? "",
//       );

//   Map<String, dynamic> toJson() => {
//         "post_id": postId ?? 0,
//         "comment_id": commentId ?? 0,
//         "customer_id": customerId ?? 0,
//         "customer_name": customerName ?? "",
//         "user_profile_pic": userProfilePic ?? "",
//         "comment": comment ?? "",
//         "has_comment_liked": hasCommentLiked ?? false,
//         "comment_like_count": commentLikeCount ?? "0",
//         "created_at": createdAt ?? "",
//         "time_ago": timeAgo ?? "",
//       };
// }

// // import 'dart:convert';

// // CommentListResponse commentListResponseFromJson(String str) =>
// //     CommentListResponse.fromJson(json.decode(str));

// // String commentListResponseToJson(CommentListResponse data) =>
// //     json.encode(data.toJson());

// // class CommentListResponse {
// //   bool status;
// //   String message;
// //   List<Comment> comments;

// //   CommentListResponse({
// //     required this.status,
// //     required this.message,
// //     required this.comments,
// //   });

// //   factory CommentListResponse.fromJson(Map<String, dynamic> json) =>
// //       CommentListResponse(
// //         status: json["status"] ?? false, // Default to false if null
// //         message: json["message"] ?? "", // Default to empty string if null
// //         comments: json["comments"] != null
// //             ? List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x)))
// //             : [],
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "status": status,
// //         "message": message,
// //         "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
// //       };
// // }

// // class Comment {
// //   int postId;
// //   int commentId;
// //   int customerId;
// //   String customerName;
// //   String comment;
// //    String likeCount;
// //   bool hasCommentLiked;

// //   Comment({
// //     required this.postId,
// //     required this.commentId,
// //     required this.customerId,
// //     required this.customerName,
// //     required this.comment,
// //         required this.likeCount,
// //     required this.hasCommentLiked,
// //   });

// //   factory Comment.fromJson(Map<String, dynamic> json) => Comment(
// //         postId: json["post_id"] ?? 0, // Default to 0 if null
// //         commentId: json["comment_id"] ?? 0, // Default to 0 if null
// //         customerId: json["customer_id"] ?? 0, // Default to 0 if null
// //         customerName: json["customer_name"] ?? "", // Default to empty string if null
// //         comment: json["comment"] ?? "", // Default to empty string if null
// //         hasCommentLiked: json["has_comment_liked"] ?? false, // Default to false if null
// //           likeCount: json["like_count"] ?? "0",
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "post_id": postId,
// //         "comment_id": commentId,
// //         "customer_id": customerId,
// //         "customer_name": customerName,
// //         "comment": comment,
// //          "like_count": likeCount,
// //         "has_comment_liked": hasCommentLiked,
// //       };
// // }
