import 'dart:convert';

JoinFestivalResponse joinFestivalResponseFromJson(String str) => JoinFestivalResponse.fromJson(json.decode(str));

String joinFestivalResponseToJson(JoinFestivalResponse data) => json.encode(data.toJson());

class JoinFestivalResponse {
  bool status;
  String message;
  List<Datum> data;

  JoinFestivalResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory JoinFestivalResponse.fromJson(Map<String, dynamic> json) => JoinFestivalResponse(
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
  String title;
  String flimFestivalDate;
  String shortDesc;
  String longDesc;
  String slug;

  Datum({
    required this.title,
    required this.flimFestivalDate,
    required this.shortDesc,
    required this.longDesc,
    required this.slug,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"] ?? '',
    flimFestivalDate: json["flim_festival_date"] ?? '',
    shortDesc: json["short_desc"] ?? '',
    longDesc: json["long_desc"] ?? '',
    slug: json["slug"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "flim_festival_date": flimFestivalDate,
    "short_desc": shortDesc,
    "long_desc": longDesc,
    "slug": slug,
  };
}
