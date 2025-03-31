import 'dart:convert';

MasterListResponse masterListResponseFromJson(String str) => MasterListResponse.fromJson(json.decode(str));

String masterListResponseToJson(MasterListResponse data) => json.encode(data.toJson());

class MasterListResponse {
  bool status;
  String message;
  List<Datum> data;

  MasterListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MasterListResponse.fromJson(Map<String, dynamic> json) => MasterListResponse(
    status: json["status"] ?? false,
    message: json["message"] ?? "",
    data: json["data"] != null ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String masterImage;
  String name;
  String profession;
  String slug;

  Datum({
     required this.id,
    required this.masterImage,
    required this.name,
    required this.profession,
    required this.slug,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    masterImage: json["master_image"] ?? "",
    name: json["name"] ?? "",
    profession: json["profession"] ?? "",
    slug: json["slug"] ?? "",
  );

  Map<String, dynamic> toJson() => {
     "id": id,
    "master_image": masterImage,
    "name": name,
    "profession": profession,
    "slug": slug,
  };
}
