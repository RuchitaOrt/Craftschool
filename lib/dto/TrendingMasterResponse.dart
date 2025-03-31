import 'dart:convert';

TrendingMasterResponse trendingMasterResponseFromJson(String str) => TrendingMasterResponse.fromJson(json.decode(str));

String trendingMasterResponseToJson(TrendingMasterResponse data) => json.encode(data.toJson());

class TrendingMasterResponse {
  bool status;
  String message;
  List<Datum> data;

  TrendingMasterResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TrendingMasterResponse.fromJson(Map<String, dynamic> json) => TrendingMasterResponse(
    status: json["status"] ?? false,
    message: json["message"] ?? '',
    data: List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String masterName;
  String description;
  String photo;
  String slug;
  String tags;

  Datum({
    required this.masterName,
    required this.description,
    required this.photo,
    required this.slug,
    required this.tags,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    masterName: json["master_name"] ?? '',
    description: json["description"] ?? '',
    photo: json["photo"] ?? '',
    slug: json["slug"] ?? '',
    tags: json["tags"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "master_name": masterName,
    "description": description,
    "photo": photo,
    "slug": slug,
    "tags": tags,
  };
}
