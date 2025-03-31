import 'dart:convert';

FaqResponse faqResponseFromJson(String str) => FaqResponse.fromJson(json.decode(str));

String faqResponseToJson(FaqResponse data) => json.encode(data.toJson());

class FaqResponse {
    bool status;
    String message;
    List<Datum> data;

    FaqResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory FaqResponse.fromJson(Map<String, dynamic> json) => FaqResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
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
    int catId;
    String categoryName;
    List<DataOfCategory> dataOfCategory;

    Datum({
        required this.catId,
        required this.categoryName,
        required this.dataOfCategory,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        catId: json["cat_id"] ?? 0,
        categoryName: json["category_name"] ?? "",
        dataOfCategory: json["data_of_category"] != null 
            ? List<DataOfCategory>.from(json["data_of_category"].map((x) => DataOfCategory.fromJson(x))) 
            : [],
    );

    Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "category_name": categoryName,
        "data_of_category": List<dynamic>.from(dataOfCategory.map((x) => x.toJson())),
    };
}

class DataOfCategory {
    int questionId;
    String question;
    String answer;

    DataOfCategory({
        required this.questionId,
        required this.question,
        required this.answer,
    });

    factory DataOfCategory.fromJson(Map<String, dynamic> json) => DataOfCategory(
        questionId: json["question_id"] ?? 0,
        question: json["question"] ?? "",
        answer: json["answer"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "question": question,
        "answer": answer,
    };
}
