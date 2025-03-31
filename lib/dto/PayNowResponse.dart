import 'dart:convert';

PayNowResponse payNowResponseFromJson(String str) => 
    PayNowResponse.fromJson(json.decode(str));

String payNowResponseToJson(PayNowResponse data) => 
    json.encode(data.toJson());

class PayNowResponse {
  bool status;
  String message;
  String? razorpayOrderId;
  String? razorpayKey;
  String? razorpaySecret;

  PayNowResponse({
    required this.status,
    required this.message,
    this.razorpayOrderId,
    this.razorpayKey,
    this.razorpaySecret,
  });

  factory PayNowResponse.fromJson(Map<String, dynamic> json) => PayNowResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        razorpayOrderId: json["razorpay_order_id"],
        razorpayKey: json["razorpay_key"],
        razorpaySecret: json["razorpay_secret"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "razorpay_order_id": razorpayOrderId,
        "razorpay_key": razorpayKey,
        "razorpay_secret": razorpaySecret,
      };
}
