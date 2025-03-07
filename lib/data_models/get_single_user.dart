import 'dart:convert';

GetSingleUser welcomeFromJson(String str) => GetSingleUser.fromJson(json.decode(str));

String welcomeToJson(GetSingleUser data) => json.encode(data.toJson());

class GetSingleUser {
  int statusCode;
  bool success;
  String message;
  Data data;

  GetSingleUser({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetSingleUser.fromJson(Map<String, dynamic> json) => GetSingleUser(
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
  String id;
  String name;
  String email;
  dynamic phone;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic about;
  dynamic image;
  dynamic location;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.about,
    required this.image,
    required this.location,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    about: json["about"],
    image: json["image"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "about": about,
    "image": image,
    "location": location,
  };
}
