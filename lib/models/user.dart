// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(Map str) => User.fromJson(str);

String userToJson(User data) => json.encode(data.toJson());

class User {
  String idUser;
  String email;
  String hash;
  String salt;
  String name;
  DateTime join;

  User({
    this.idUser,
    this.email,
    this.hash,
    this.salt,
    this.name,
    this.join,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["id_user"],
        email: json["email"],
        hash: json["hash"],
        salt: json["salt"],
        name: json["name"],
        join: DateTime.parse(json["join"]),
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "email": email,
        "hash": hash,
        "salt": salt,
        "name": name,
        "join": join.toIso8601String(),
      };
}
