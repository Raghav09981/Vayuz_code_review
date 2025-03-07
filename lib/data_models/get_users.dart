import 'dart:convert';

GetUsers welcomeFromJson(String str) => GetUsers.fromJson(json.decode(str));

String welcomeToJson(GetUsers data) => json.encode(data.toJson());

class GetUsers {
  int statusCode;
  bool success;
  String message;
  int totalData;
  int page;
  int limit;
  List<Datum> data;

  GetUsers({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.totalData,
    required this.page,
    required this.limit,
    required this.data,
  });

  factory GetUsers.fromJson(Map<String, dynamic> json) => GetUsers(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    totalData: json["totalData"],
    page: json["page"],
    limit: json["limit"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "totalData": totalData,
    "page": page,
    "limit": limit,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String name;
  String email;
  String? phone;
  bool? status;
  String? location;
  String? about;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic image;

  Datum({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    this.location,
    this.about,
    required this.createdAt,
    required this.updatedAt,
    this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"] as String?,
    status: json["status"],
    location: json["location"],
    about: json["about"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "status": status,
    "location": location,
    "about": about,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "image": image,
  };
}
