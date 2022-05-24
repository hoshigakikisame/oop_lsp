import 'dart:convert';

List<UserProfile> userProfileFromJson(String str) => List<UserProfile>.from(
    json.decode(str).map((x) => UserProfile.fromJson(x)));

String userProfileToJson(List<UserProfile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserProfile {
  UserProfile({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.role,
    required this.username,
    required this.email,
  });

  int id;
  DateTime createdAt;
  String userId;
  String role;
  String username;
  String email;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        userId: json["user_id"],
        role: json["role"],
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "user_id": userId,
        "role": role,
        "username": username,
        "email": email,
      };
}
