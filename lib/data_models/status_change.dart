import 'dart:convert';

StatusChange welcomeFromJson(String str) =>
    StatusChange.fromJson(json.decode(str));

String welcomeToJson(StatusChange data) => json.encode(data.toJson());

class StatusChange {
  int statusCode;
  bool success;
  String message;
  Data data;

  StatusChange({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory StatusChange.fromJson(Map<String, dynamic> json) => StatusChange(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String message;
  Data({
    required this.message,
  });
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
