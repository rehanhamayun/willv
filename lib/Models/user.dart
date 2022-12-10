import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int? id;
  String? username;
  String? email;
  String? password;
  DateTime? createdAt;
  bool? banned;
  bool? active;
  String? resetCode;
  String? adresse;
  DateTime? resetCreatedAt;
  String? firstName;
  String? lastName;
  int? age;
  int? nbrAttemp;

  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.createdAt,
    this.banned,
    this.active,
    this.resetCode,
    this.adresse,
    this.resetCreatedAt,
    this.firstName,
    this.lastName,
    this.age,
    this.nbrAttemp,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0,
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        banned: json["banned"] ?? false,
        active: json["active"] ?? false,
        resetCode: json["resetCode"] ?? "",
        adresse: json["adresse"] ?? "",
        resetCreatedAt: json["resetCreatedAt"] ?? DateTime.now(),
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        age: json["age"] ?? 0,
        nbrAttemp: json["nbrAttemp"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        // "createdAt": createdAt.toIso8601String(),
        "createdAt": createdAt,
        "banned": banned,
        "active": active,
        "resetCode": resetCode,
        "adresse": adresse,
        "resetCreatedAt": resetCreatedAt,
        "firstName": firstName,
        "lastName": lastName,
        "age": age,
        "nbrAttemp": nbrAttemp,
      };
}
