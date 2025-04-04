import 'dart:convert';

CustomerInfoResponse customerInfoResponseFromJson(String str) => CustomerInfoResponse.fromJson(json.decode(str));

String customerInfoResponseToJson(CustomerInfoResponse data) => json.encode(data.toJson());

class CustomerInfoResponse {
  bool status;
  String message;
  List<Datum> data;

  CustomerInfoResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CustomerInfoResponse.fromJson(Map<String, dynamic> json) => CustomerInfoResponse(
    status: json["status"] ?? false,
    message: json["message"] ?? "",
    data: json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  List<Customer> customer;
  String appLanguage;
  List<MemberShip> memberShip;
  String paymentMethod;

  Datum({
    required this.customer,
    required this.appLanguage,
    required this.memberShip,
    required this.paymentMethod,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    customer: json["customer"] == null ? [] : List<Customer>.from(json["customer"].map((x) => Customer.fromJson(x))),
    appLanguage: json["app_language"] ?? "",
    memberShip: json["memberShip"] == null ? [] : List<MemberShip>.from(json["memberShip"].map((x) => MemberShip.fromJson(x))),
    paymentMethod: json["payment_method"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "customer": List<dynamic>.from(customer.map((x) => x.toJson())),
    "app_language": appLanguage,
    "memberShip": List<dynamic>.from(memberShip.map((x) => x.toJson())),
    "payment_method": paymentMethod,
  };
}

class Customer {
  int id;
  String firstName;
  String lastName;
  String email;
  String phoneNo;
  String userProfilePic;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    required this.userProfilePic,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"] ?? 0,
    firstName: json["first_name"] ?? "",
    lastName: json["last_name"] ?? "",
    email: json["email"] ?? "",
    phoneNo: json["phone_no"] ?? "",
     userProfilePic: json["user_profile_pic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone_no": phoneNo,
     "user_profile_pic": userProfilePic,
  };
}

class MemberShip {
  String planName;
  String planMembershipDate;

  MemberShip({
    required this.planName,
    required this.planMembershipDate,
  });

  factory MemberShip.fromJson(Map<String, dynamic> json) => MemberShip(
    planName: json["plan_name"] ?? "",
    planMembershipDate: json["plan_membership_date"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "plan_name": planName,
    "plan_membership_date": planMembershipDate,
  };
}
